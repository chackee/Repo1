﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MessageModule.configuration
{
    public class SMSConfiguration
    {
		private string _accountSid;
		private string _authToken;
		private string _source;
		private string[] _targets;

        public string AccountSid { get { return _accountSid; } set { _accountSid = value; } }
		public string AuthToken { get { return _authToken; } set { _authToken = value; } }
		public string Source { get { return _source; } set { _source = value; } }
		public string[] Targets { get { return _targets; } set { _targets = value; } }

		internal static SMSConfiguration FromSection()
        {
			SMSConfigSection section = (SMSConfigSection)ConfigurationManager.GetSection(SMSConfigSection.ConfigSectionName);

			SMSConfiguration cfg = new SMSConfiguration();
			cfg.AccountSid = section.AccountSid;
			cfg.AuthToken = section.AuthToken;
			cfg.Source = section.Source;
			cfg.Targets = section.Targets;

			return cfg;
		}













		/*static SMSConfiguration _instance = null;
		public static SMSConfiguration Instance
		{
			get
			{
				if (_instance == null) throw new InvalidOperationException("Configuration hasn't been initialized yet");
				return _instance;
			}

			set
			{
				if (_instance != null) throw new InvalidOperationException("Configuration has been initialized already");
				_instance = value;
			}
		}

		public SMSConfiguration()
		{

		}*/
	}
}