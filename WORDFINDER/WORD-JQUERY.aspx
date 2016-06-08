<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WORD-JQUERY.aspx.cs" Inherits="WebApplication13.WebForm1" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title></title>
<script src="Scripts/jquery-2.2.1.min.js"></script>
<link href="CSS/Paragraph.css" rel="stylesheet" />
<script src="Scripts/code-jquery.js"></script>
</head>
<body>
<form id="textstatisticsJQUERY" runat="server">
<div>
This is JQuery Code with a WebService <a href="WORD-ANGULARJS.aspx">Click here to view the Angular equivalent running</a>
<br />
<br />
WORD LETTER FILTER<br />
<textarea id="txFilter" ></textarea>
<br />
DOCUMENT PASSAGE TO EXAMINE<br />
<textarea id="txRequest" ></textarea>
<br />
RESULTS<br />
<div      id="divResponse" style="border:1px solid black;text-align:center;">
</div>
</div>
</form>
</body>
</html>
