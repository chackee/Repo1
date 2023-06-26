using MessageModule.SMS;

namespace MessageModuleConsoleAppv2
{
    public class Program
    {
        static void Main(string[] args)
        {
            try
            {
                bool isInitialized = InitializeApp();

                if (!isInitialized) { Console.WriteLine("Application could not be initialized"); Console.ReadKey(); return; }

                string message = GenerateMessage();
                if (string.IsNullOrWhiteSpace(message)) { Console.WriteLine("Application will be closed"); Console.ReadKey(); return; }

                var sms = new SMSModule();

                sms.Process(message);
            }
            catch (Exception ex)
            {
                Console.WriteLine("An error occurred during runtime and message could not be sent: {0}", ex.Message.ToString());
                Console.ReadKey();
            }

        }

        private static string GenerateMessage()
        {
            string result = "";

            while (string.IsNullOrWhiteSpace(result))
            {
                Console.WriteLine("Please enter a message body or enter \'0\' to cancel: ");

                result = Console.ReadLine().Trim();
                if (result == "0") return "";
            }

            return result;
        }

        private static bool InitializeApp()
        {
            try
            {
                string sid = "PleaseEnterSID";
                string token = "PleaseEnterToken";
                string source = "SourcePhoneNumber";
                string[] targets = new string[1] { "TargetPhoneNumbers" };

                SMSModuleInstaller.Instance.Configure(sid, token, source, targets);

                return true;
            }
            catch
            {
                return false;
            }
        }
    }
}