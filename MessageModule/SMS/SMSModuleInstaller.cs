using MessageModule.configuration;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MessageModule.SMS
{
    public class SMSModuleInstaller
    {
        private SMSConfiguration _configuration;
        public SMSConfiguration Configuration { get { return _configuration; } }

        public void Configure(SMSConfiguration config)
        {
            CheckState();

            _configuration = config;
        }

        public void Configure(string sid, string token, string source, string[] targets)
        {
            CheckState();

            SMSConfiguration configuration = new SMSConfiguration();
            configuration.AccountSid = sid;
            configuration.AuthToken = token;
            configuration.Source = source;
            configuration.Targets = targets;

            _configuration = configuration;
        }

        private void CheckState()
        {
            if (_configuration != null) throw new InvalidOperationException("Configuration already set!");
        }

        #region singleton

        private SMSModuleInstaller() { }
        static SMSModuleInstaller() { }
        private static SMSModuleInstaller _instance = new SMSModuleInstaller();
        public static SMSModuleInstaller Instance { get { return _instance; } }

        #endregion
    }
}
