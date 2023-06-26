using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MessageModule.interfaces
{
    interface ISender
    {
        public void Process(string message);
    }
}
