using System.Security.Cryptography;
using System.Text;

namespace course_project_spring_2023_api.Services
{
    public static class PasswordService
    {
        private const string SecurityKey = "6dxgC86^R?F*T,7h";
        public static bool ComparePassword(string encryptedKey, string decryptedKey)
        {
            return encryptedKey == EncryptPlainTextToCipherText(decryptedKey);
        }

        public static string EncryptPlainTextToCipherText(string PlainText)
        {
            byte[] toEncryptedArray = Encoding.UTF8.GetBytes(PlainText);

            var objMD5CryptoService = new MD5CryptoServiceProvider();
            byte[] securityKeyArray = objMD5CryptoService.ComputeHash(Encoding.UTF8.GetBytes(SecurityKey));
            objMD5CryptoService.Clear();

            var objTripleDESCryptoService = new TripleDESCryptoServiceProvider
            {
                Key = securityKeyArray,
                Mode = CipherMode.ECB,
                Padding = PaddingMode.PKCS7
            };

            var objCrytpoTransform = objTripleDESCryptoService.CreateEncryptor();
            byte[] resultArray = objCrytpoTransform.TransformFinalBlock(toEncryptedArray, 0, toEncryptedArray.Length);
            objTripleDESCryptoService.Clear();
            return Convert.ToBase64String(resultArray, 0, resultArray.Length);
        }

        public static string DecryptCipherTextToPlainText(string CipherText)
        {
            byte[] toEncryptArray = Convert.FromBase64String(CipherText);
            var objMD5CryptoService = new MD5CryptoServiceProvider();

            byte[] securityKeyArray = objMD5CryptoService.ComputeHash(Encoding.UTF8.GetBytes(SecurityKey));
            objMD5CryptoService.Clear();

            var objTripleDESCryptoService = new TripleDESCryptoServiceProvider
            {
                Key = securityKeyArray,
                Mode = CipherMode.ECB,
                Padding = PaddingMode.PKCS7
            };

            var objCrytpoTransform = objTripleDESCryptoService.CreateDecryptor();
            byte[] resultArray = objCrytpoTransform.TransformFinalBlock(toEncryptArray, 0, toEncryptArray.Length);
            objTripleDESCryptoService.Clear();

            return Encoding.UTF8.GetString(resultArray);
        }
    }
}
