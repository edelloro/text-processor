using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;




namespace UnitTestProjectWordFinder
{
    [TestClass]
    public class UnitTestParagraphStatistics
    {
        [TestMethod]
        public void TestMethod_TestWebServiceResult()
        {

            WebApplication13.WebService1 ws = new WebApplication13.WebService1();
 
            string result = ws.GetTextStatistics("ERIC", "ERIC WAS HERE");

            string testOk = "<table><tr><td>WORD</td><td>COUNT</td></tr></tr><tr><td>E</td><td>1</td></tr><tr><td>R</td><td>0</td></tr><tr><td>I</td><td>0</td></tr><tr><td>C</td><td>0</td></tr><tr><td>W</td><td>0</td></tr><tr><td>A</td><td>0</td></tr><tr><td>S</td><td>0</td></tr><tr><td>H</td><td>0</td></tr></table>";

            Assert.AreEqual(testOk , result , "WORD COUNT IS INCORRECT OR SCHEMA MODIFIED");

        }
    }
}

