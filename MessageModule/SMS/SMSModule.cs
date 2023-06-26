using MessageModule.configuration;
using MessageModule.interfaces;
using System.Configuration;
using Twilio;
using Twilio.Rest.Api.V2010.Account;

namespace MessageModule.SMS
{
    public class SMSModule : ISender
    {
        private static SMSConfiguration _config;

        static SMSModule()
        {
            if (SMSModuleInstaller.Instance.Configuration != null) _config = SMSModuleInstaller.Instance.Configuration;
            else _config = SMSConfiguration.FromSection();

            if (_config == null) throw new ConfigurationErrorsException("SMS Module configuration not found, use SMSModuleInstaller or set config section: " + SMSConfigSection.ConfigSectionName);
        }

        public void Process(string message)
        {
            ProcessMessage(message);
        }

        private void ProcessMessage(string message)
        {
            TwilioClient.Init(_config.AccountSid, _config.AuthToken);

            int targetCount = _config.Targets.Length;

            for (int i = 0; i < targetCount; i++)
            {
                var msg = MessageResource.Create(
                    body: message,
                    from: _config.Source,
                    to: _config.Targets[i]
                    );
            }
        }
    }
}