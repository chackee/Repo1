using System;
using System.Collections.Generic;
using System.Collections.Concurrent;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Threading;
using System.Diagnostics;
using System.Text.RegularExpressions;

namespace ExampleProj
{ 
    
    public class Program
    {
        private static string RemoveDuplicateCharacters(string input)
        {
            List<char> characters = new List<char>();
            StringBuilder stringBuilder = new StringBuilder();
            for(int i = 0; i < input.Length; i++)
            {
                if(!characters.Contains(input[i]))
                {
                    characters.Add(input[i]);
                    stringBuilder.Append(input[i]);
                }
            }

            return stringBuilder.ToString();
        }

        public static void Main(string[] args)
        {
            System.Console.WriteLine("Please enter a string: ");
            string input = Console.ReadLine();

            if (String.IsNullOrWhiteSpace(input))
            {
                Console.WriteLine("You have entered an invalid string! Input cannot be null or white space!");
            }
            else
            {
                string result = RemoveDuplicateCharacters(input);
                Console.WriteLine(result);
                Console.ReadKey();
            }
        }
    }
}