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
<table>
<tr><td>WORD STARTING LETTER FILTER<br />
<textarea id="txFilter">ZORK ADVENTURE</textarea></td></tr>
<tr><td>SAMPLE PARAGRAPH<br />
<textarea id="txRequest"></textarea></td></tr>
<tr>    
<td>
RESULTS<br />
<div id="divResult">
<div id="divResultInner"></div>
</div>
</td>
</tr>             
</table>
</div>
</form>
</body>
</html>
