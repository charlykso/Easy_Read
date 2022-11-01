using System;
using System.Security.Cryptography;
using System.Text;

namespace API.Controllers
{
    public class StringEncryption
    {
        public static async Task<string> EncryptString(string key, string plainText)  
        {  
            byte[] iv = new byte[16];  /*32 bits key*/
            byte[] array;

            using (Aes aes = Aes.Create())  
            { 
                aes.Key = Encoding.UTF8.GetBytes(key);  
                aes.IV = iv;

                ICryptoTransform encryptor = aes.CreateEncryptor(aes.Key, aes.IV);  

                using (MemoryStream memoryStream = new MemoryStream())  
                {  
                    using (CryptoStream cryptoStream = new CryptoStream((Stream)memoryStream, encryptor, CryptoStreamMode.Write))  
                    {  
                        using (StreamWriter streamWriter = new StreamWriter((Stream)cryptoStream))  
                        {  
                           await streamWriter.WriteAsync(plainText);
                        }  

                        array = memoryStream.ToArray();
                    }  
                }  
            }  

            return Convert.ToBase64String(array);
        }

        public static async Task<string> DecryptString(string key, string cipherText)
        {
            try
            {
                byte[] iv = new byte[16];  /*32 bits key*/

                byte[] cipherBytes = Convert.FromBase64String(cipherText);
                string plaintext = null!;

                using (Aes aes = Aes.Create())
                {
                    aes.Key = Encoding.UTF8.GetBytes(key);
                    aes.IV = iv;

                    ICryptoTransform decryptor = aes.CreateDecryptor(aes.Key, aes.IV);

                    using (MemoryStream memoryStream = new MemoryStream(cipherBytes))
                    {
                        using (CryptoStream cryptoStream = new CryptoStream(memoryStream, decryptor, CryptoStreamMode.Read))
                        {
                            using (StreamReader streamReader = new StreamReader(cryptoStream))
                            {
                                plaintext = await streamReader.ReadToEndAsync();
                            }
                        }
                    }
                }

                return plaintext;
            }
            catch (System.Exception ex)
            {
                
                return (ex.Message);
            }
            
        }
    }
}