using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Threading;

namespace ExampleProj
{
    internal class Program
    {
        static char[] spaces = new char[] { '1', '2', '3', '4', '5', '6', '7', '8', '9' };
        static int player = 1;
        static int choice;
        static int flag;
        static string input;
        static bool? result = null;

        /// <summary>
        /// Drawing a game board
        /// </summary>
        static void DrawBoard()
        {
            Console.WriteLine("     |     |    ");
            Console.WriteLine("  {0}  |  {1}  |  {2}  ", spaces[0], spaces[1], spaces[2]);
            Console.WriteLine("_____|_____|_____");
            Console.WriteLine("     |     |    ");
            Console.WriteLine("  {0}  |  {1}  |  {2}  ", spaces[3], spaces[4], spaces[5]);
            Console.WriteLine("_____|_____|_____");
            Console.WriteLine("     |     |    ");
            Console.WriteLine("  {0}  |  {1}  |  {2}  ", spaces[6], spaces[7], spaces[8]);
            Console.WriteLine("     |     |    ");
        }

        /// <summary>
        /// Checks for Win and Tie
        /// </summary>
        /// <returns></returns>
        static int CheckWin()
        {
            if (spaces[0] == spaces[1] &&
               spaces[1] == spaces[2] ||
               spaces[3] == spaces[4] &&
               spaces[4] == spaces[5] ||
               spaces[6] == spaces[7] &&
               spaces[7] == spaces[8] ||
               spaces[0] == spaces[3] &&
               spaces[3] == spaces[6] ||
               spaces[1] == spaces[4] &&
               spaces[4] == spaces[7] ||
               spaces[2] == spaces[5] &&
               spaces[5] == spaces[8] ||
               spaces[0] == spaces[4] &&
               spaces[4] == spaces[8] ||
               spaces[2] == spaces[4] &&
               spaces[4] == spaces[6])
            {
                return 1;
            }
            else if (spaces[0] != '1' &&
                    spaces[1] != '2' &&
                    spaces[2] != '3' &&
                    spaces[3] != '4' &&
                    spaces[4] != '5' &&
                    spaces[5] != '6' &&
                    spaces[6] != '7' &&
                    spaces[7] != '8' &&
                    spaces[8] != '9')
            {
                return -1;

            }
            else
            {
                return 0;
            }
        }

        /// <summary>
        /// Draw X symbol into game board with correct position
        /// </summary>
        /// <param name="pos"></param>
        static void DrawX(int pos)
        {
            spaces[pos] = 'X';
        }

        /// <summary>
        /// Draw Y symbol into game board with correct position
        /// </summary>
        /// <param name="pos"></param>
        static void DrawO(int pos)
        {
            spaces[pos] = 'O';
        }

        /// <summary>
        /// Tic tac toe main game logic
        /// </summary>
        /// <param name="args"></param>
        static void Main(string[] args)
        {
            do
            {
                Console.Clear();
                Console.WriteLine("Player 1 : X and Player 2 : O" + "\n");

                // Identifies who's turn it is.. %2 always return 0 or 1
                if (player % 2 == 0)
                {
                    Console.WriteLine("Player 2's turn");
                }
                else
                {
                    Console.WriteLine("Player 1's turn");
                }
                Console.WriteLine("\n");
                DrawBoard();

                // Check user input if its a number and if its between 1 - 9
                while (true)
                {
                    input = Console.ReadLine();
                    result = int.TryParse(input, out choice);
                    if (result == false)
                    {
                        Console.WriteLine("You did not enter a number. Try again.");
                        continue;
                    }

                    if (!(choice > 0 && choice < 10))
                    {
                        Console.WriteLine("You did not enter correct number. Try again.");
                        continue;
                    }
                    else
                    {
                        break;
                    }
                }
                choice = choice - 1;
                // Check if space is free or not and then applies X or O
                if (spaces[choice] != 'X' &&
                    spaces[choice] != 'O')
                {
                    if (player % 2 == 0)
                    {
                        DrawO(choice);
                    }
                    else
                    {
                        DrawX(choice);
                    }
                    player++; // switch to next player
                }
                else
                {
                    Console.WriteLine("Sorry, the row {0} is already marked with {1} \n", choice + 1, spaces[choice]);
                    Console.WriteLine("Please wait 4 seconds, board is loading again...");
                    Thread.Sleep(4000);
                }

                flag = CheckWin();
            } while (flag != 1 && flag != -1);
            // if its win, show Board result

            Console.Clear();
            DrawBoard();

            if (flag == 1)
            {
                Console.WriteLine("Player {0} has won", (player % 2) + 1);
            }
            else
            {
                Console.WriteLine("Tie Game");
            }

            Console.ReadLine();
        }
    }
}
