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
    class Person
    {
        public string name;
        public int age;
    }

    public class Program
    {

        public static void Main(string[] args)
        {
            List<Person> people = new List<Person>() { new Person() { name = "John", age = 25 } };
            List<Person> people2 = new List<Person>() { new Person() { name = "John", age = 25 } };

            Debug.WriteLine(people.SequenceEqual(people2));
            Debug.WriteLine("Hello World!");
        }
    }
}