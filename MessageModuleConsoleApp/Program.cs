using MessageModule.SMS;

namespace MessageModuleConsoleApp
{
    public class Program
    {
        static void Main(string[] args)
        {
            try
            {
                string message = GenerateMessage();
                if (string.IsNullOrWhiteSpace(message)) { Console.WriteLine("Application will be closed"); Console.ReadKey(); return; }

                var sms = new SMSModule();

                sms.Process(message);
            }
            catch(Exception ex)
            {
                Console.WriteLine("An error occurred during runtime and message could not be sent: {0}", ex.Message.ToString());
                Console.ReadKey();
            }
            
        }

        private static string GenerateMessage()
        {
            string result = "";

            while(string.IsNullOrWhiteSpace(result))
            {
                Console.WriteLine("Please enter a message body or enter \'0\' to cancel: ");

                result = Console.ReadLine().Trim();
                if (result == "0") return "";
            }

            return result;
        }
    }
}