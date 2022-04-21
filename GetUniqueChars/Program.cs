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
        private static List<char> UniqueCharacters = new List<char>();

        private static List<char> SetUniqueChars(string input)
        {
            UniqueCharacters.Clear();
                foreach (char c in input)
            {
                if (!UniqueCharacters.Contains(c))
                {
                    UniqueCharacters.Add(c);
                }
            }

            return UniqueCharacters;
        }

        private static void PrintUniqueChars()
        {
            if(UniqueCharacters.Count != 0)
            {
                foreach (char c in UniqueCharacters)
                {
                    Console.WriteLine(c);
                }
            }
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
                SetUniqueChars(input);
                PrintUniqueChars();

                Console.ReadKey();
            }
        }
    }
}