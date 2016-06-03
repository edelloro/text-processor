<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ParagraphStatisticsANGULARJS.aspx.cs" Inherits="WebApplication13.WebForm1Angular" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" ng-app="myApp" >
<head runat="server">
    <title></title>  
    <link href="CSS/Paragraph.css" rel="stylesheet" />
    <script src="Scripts/angular.js"></script>
    <script src="Scripts/code-angular.js"></script>  
</head>
<body>
<form id="textstatisticsANGULAR" runat="server" ng-controller="myController">
<div>
<textarea id="txFilter"   ng-model="textFilter"     ng-keyup="myFunct($event);"></textarea>
<br />
<textarea id="txRequest"  ng-model="textRequest"    ng-keyup="myFunct($event);"></textarea>
<br />
<div   id="divResponse"   ng-model="textResponse"   style="border:1px solid black;text-align:center;">

<table>
  <tr><td>STARTING LETTER</td><td>WORD COUNT</td></tr>
  <tr ng-repeat="item in textResponse">
    <td>{{ item.key }}</td>
    <td>{{ item.payload }}</td>
  </tr>
</table>
</div>
</div>
</form>
</body>
</html>
