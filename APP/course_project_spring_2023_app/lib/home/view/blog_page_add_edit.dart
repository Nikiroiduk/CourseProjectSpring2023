import 'package:api_repository/api_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/blog/blog_bloc.dart';

class BlogPageAddEdit extends StatefulWidget {
  BlogPageAddEdit({super.key, this.blog});

  Blog? blog;

  @override
  State<BlogPageAddEdit> createState() => _BlogPageAddEditState(blog);
}

class _BlogPageAddEditState extends State<BlogPageAddEdit> {
  _BlogPageAddEditState(Blog? blog) : _blog = blog;
  Blog? _blog;
  late String _name = _blog == null ? '' : _blog?.name as String;

  late String _content = _blog == null ? '' : _blog?.content as String;

  late final List<Tag> _tags =
      _blog == null ? <Tag>[] : _blog?.tags as List<Tag>;

  String _tag = '';

  final _nameController = TextEditingController();
  final _contentController = TextEditingController();

  late final String AddUpdateBtn = _blog == null ? 'Add' : 'Update';

  @override
  void initState() {
    _nameController.text = _name;
    _contentController.text = _content;
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0, left: 8, right: 8, bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              maxLength: 50,
              onSubmitted: (value) => _name = value,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  label: const Text('Blog name')),
            ),
            GestureDetector(
              onTap: () {
                var dialog = AlertDialog(
                  title: const Text('Add new tag'),
                  content: TextField(
                    maxLength: 20,
                    onChanged: (value) => _tag = value,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        hintText: 'Tag'),
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            _tags.add(Tag(id: 0, name: _tag));
                            _tag = '';
                            Navigator.of(context, rootNavigator: true).pop();
                          });
                        },
                        icon: const Icon(Icons.add)),
                    IconButton(
                        onPressed: () {
                          _tag = '';
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                        icon: const Icon(Icons.close)),
                  ],
                );
                showDialog(
                    context: context,
                    builder: (BuildContext context) => dialog);
              },
              child: const Chip(
                label: Text('Add'),
                avatar: Icon(Icons.add),
              ),
            ),
            Wrap(
              spacing: 6,
              children: List<Widget>.generate(_tags.length, (int index) {
                return Chip(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  label: Text(_tags[index].name),
                  onDeleted: () {
                    setState(() {
                      _tags.removeAt(index);
                    });
                  },
                );
              }),
            ),
            Expanded(
              child: TextField(
                controller: _contentController,
                textAlignVertical: TextAlignVertical.top,
                maxLines: 300,
                onSubmitted: (value) => _contentController.text = value,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                  child: Text(AddUpdateBtn),
                  onPressed: () {
                    AddUpdateBtn == "Add"
                        ? Navigator.pop<Blog>(
                            context,
                            Blog(
                                id: 0,
                                name: _nameController.text,
                                content: _contentController.text,
                                tags: _tags))
                        : Navigator.pop<Blog>(
                            context,
                            Blog(
                                id: _blog!.id,
                                name: _nameController.text,
                                content: _contentController.text,
                                tags: _tags));
                  },
                )),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                    child: ElevatedButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
