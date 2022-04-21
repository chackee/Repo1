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
        private static int GetNumberOfWords(string input)
        {
            List<string> words = new List<string>();

            var a = input.Split(' ');
            return a.Count();
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
                int result = GetNumberOfWords(input);
                Console.WriteLine(result);
                Console.ReadKey();
            }
        }
    }
}