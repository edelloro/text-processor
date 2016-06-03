<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ParagraphStatisticsANGULARJS.aspx.cs" Inherits="WebApplication13.WebForm1Angular" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" ng-app="myApp" >
<head runat="server">
    <title></title>
   
    <link href="CSS/Paragraph.css" rel="stylesheet" />
 
    <script src="Scripts/angular.js"></script>

    <script>

    var app = angular.module("myApp", []);

    app.controller('myController', function ($scope, $http) {

    $scope.textFilter = "ZORK ADVENTURE";
    $scope.textResponse = [];          
    $scope.myFunct = function (keyEvent) {
    var myrequest = $scope.textRequest;
    var myfilter = $scope.textFilter;

    $http({
        method: 'POST',
        url: "/WebServiceStatistics.asmx/GetTextStatistics",
        dataType: 'json',
        data: { 'paragraph': escape(myrequest) , 'filter' : escape(myfilter) },
        contentType: 'application/json; charset=utf-8'
    }).success(function (response) {
        var data = response.d;
        $scope.textResponse = data;
        $scope.$apply();
                   
    }).error(function (data, status, headers, config) {
        //$scope.textResponse = "ERROR";
    });        
    } //KEY EVENT

    $scope.CallWebServiceInit = function () {
               
        $http({
            method:      'POST',
            url: '/WebServiceStatistics.asmx/GetZorkText',
            dataType: 'json',
            data: {}, //SEND JSON RETURN JSON
            //data:   {name:'TEST123'}             
            contentType: 'application/json; charset=utf-8' 
        }).success(function (response) {
            var data = response.d;
            $scope.textRequest = data.payload;
                 
            $http({
                method: 'POST',
                url: "/WebServiceStatistics.asmx/GetTextStatistics",
                dataType: 'json',
                data: { 'paragraph': escape(data.payload), filter: escape($scope.textFilter) },
                contentType: 'application/json; charset=utf-8'
            }).success(function (response) {

                var data = response.d;
                      
                $scope.textResponse = data;
                    
            }).error(function (data, status, headers, config) {
                alert('error');
                //$scope.textResponse = "ERROR";
            });

        }).error(function (data, status, headers, config) {  }); //$http
    }; // CALL WEB SERVICE

    $scope.CallWebServiceInit();

}); //CONTROLLER

</script>
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
