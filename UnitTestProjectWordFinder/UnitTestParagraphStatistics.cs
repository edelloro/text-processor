using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Collections.Generic;
using WebApplication13;





namespace UnitTestProjectWordFinder
{
    [TestClass]
    public class UnitTestParagraphStatistics
    {

        [TestMethod]
        public void TestMethod_TestWebServiceResult()
        {

            WebApplication13.WebService1 ws = new WebApplication13.WebService1();
 
            List<WebService1.JSONMessage> result = ws.GetTextStatistics(   "APPLE ANDREW BANANA CARROT FROG", "ABC" );

            Assert.AreEqual(result.Count , 3 , "LETTER FILTER COUNT IS INCORRECT");

        }
    }
}

