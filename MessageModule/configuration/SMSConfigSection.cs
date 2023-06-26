using System;
using System.Configuration;

namespace MessageModule.configuration
{
    public class SMSConfigSection : ConfigurationSection
    {
        public static string ConfigSectionName = "NUBEO/SMSModule";

        public string[] Targets { get; set; }
        [ConfigurationProperty("sid", IsRequired = true)]
		public string AccountSid { get { return ((string)this["sid"]).Trim(); } }

		[ConfigurationProperty("token", DefaultValue = "true", IsRequired = true)]
		public string AuthToken { get { return ((string)this["token"]).Trim(); } }

		[ConfigurationProperty("source", DefaultValue = "true", IsRequired = true)]
		public string Source { get { return ((string)this["source"]).Trim(); } }

		[ConfigurationProperty("target", DefaultValue = "true", IsRequired = true)]
		public string TargetElement { get { return ((string)this["target"]).Trim(); } }

		public SMSConfigSection() : base() { }

        protected override void PostDeserialize()
        {
            base.PostDeserialize();

            Targets = TargetElement.Split(",");
        }
    }
}
