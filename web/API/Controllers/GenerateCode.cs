using System;

namespace API.Controllers
{
    public class GenerateCode
    {
        public string generateCode()
        {
                string[] newNum = new string[6];
                Random random = new Random();

                for (int i = 0; i < 6; i++)
                {
                    newNum[i] = random.Next(10).ToString();
                }
                string codeRand = string.Join("", newNum);
                return (codeRand);
        }
    }
}