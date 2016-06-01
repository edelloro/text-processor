<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ParagraphStatisticsANGULARJS.aspx.cs" Inherits="WebApplication13.WebForm1Angular" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" ng-app="myApp" >
<head runat="server">
    <title></title>
    <style>
        body {
            font-size: x-large;
        }

        table {
            width: 100%;
            font-size: x-large;
        }

        #txFilter {
            font-size: x-large;
            width: 100%;
            height: 50px;
            border: 1px solid black;
        }

        #txRequest {
            font-size: x-large;
            width: 100%;
            height: 300px;
            max-height: 300px;
            border: 1px solid black;
        }

        #divResult {
            font-size: x-large;
            width: 100%;
            height: 300px;
            max-height: 300px;
            border: 1px solid black;
            overflow-y: scroll;
        }

        #divResultInner {
            font-size: large;
            width: 600px;
            text-align: center;
        }
    </style>

    <!-- COULD BE BUNDLED -->

    <script src="Scripts/angular.js"></script>

    <script>

            var app = angular.module("myApp", []);

            app.controller('myController', function ($scope, $http) {

            $scope.textFilter = "ZORK ADVENTURE";

            $scope.CallWebServiceInit = function () {
                $http({
                    method:      'POST',
                    url: '/WebServiceStatistics.asmx/GetZorkText',
                    dataType: 'json',
                    data: {}, //I GIVE YOU JSON PLEASE GIVE ME BACK JSON
                    //data:   {name:'ERIC123ERIC'}             
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

                }).error(function (data, status, headers, config) {


                }); //WEB SERVICE
            }; // CALL WEB SERVICE

          




            $scope.myFunct = function (keyEvent) {
              
                var myrequest = $scope.textRequest;
                var myfilter = $scope.textFilter;
                
                //alert(myrequest);
                //alert(myfilter);

                $http({
                    method: 'POST',
                    url: "/WebServiceStatistics.asmx/GetTextStatistics",
                    dataType: 'json',
                    data: { 'paragraph': 'ERIC WAS HERE AND ERIC IS GOOD' , 'filter' : 'ABC' },
                    caontentType: 'application/json; charset=utf-8'
                }).success(function (response) {
                    
                    $scope.textRequest = 'AAA BBB CCC DDD EEE FFF GGG HHH';
                    $scope.textFilter  = 'ABC';

                    var data = response.d;

                    $scope.textResponse = null;

                    $scope.$apply();

                    //setTimeout(function () { $scope.$apply(); }, 2000);

                    //alert($scope.textResponse);

                    //$scope.$apply();

                }).error(function (data, status, headers, config) {
                    //$scope.textResponse = "ERROR";
                });        
            } //KEY EVENT




            $scope.CallWebServiceInit();
        }); //CONTROLLER

</script>
</head>
<body>
<form id="textstatisticsANGULAR" runat="server">
<div>
<textarea id="txFilter"  ng-model="textFilter"   ng-controller="myController"></textarea>
<br />
<textarea id="txRequest" ng-model="textRequest"  ng-controller="myController" ng-keypress="myFunct($event);"></textarea>
<br />
<div  id="divResponse"   ng-model="textResponse" ng-controller="myController" style="border:1px solid black;text-align:center;">
<table>
  <tr><td>STARTING LETTER</td><td>WORD COUNT</td></tr>
  <tr ng-repeat="x in textResponse">
    <td>{{ x.key }}</td>
    <td>{{ x.payload }}</td>
  </tr>
</table>
</div>
</div>
</form>
</body>
</html>
