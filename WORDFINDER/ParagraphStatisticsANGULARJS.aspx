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

            //$scope.myRequest = "3";
            //$scope.myResponse = "4";

            //$scope.textRequest = "Welcome to the Pleasure dome";
            //$scope.textResponse = "";

            //$scope.$watch("textRequest",
            //    function (newValue, oldValue) {
            //    /* change noticed */
            //    //alert(oldValue);
            //});



            $scope.CallWebService = function () {

                alert('WebServiceCalled');

               
                $http({

                    method:      'POST',
                    url:         '/WebServiceStatistics.asmx/HelloJson',
                    dataType:    'json',
                //  data:        {'name':'ERIC123ERIC'},             
                    contentType: 'application/json; charset=utf-8' 
               

                }).success(function (response) {

                    alert('CALLED SUCCESS');

                    //alert('success:\n' + JSON.stringify(response));
                    //alert(response.payload);
                  
                    $scope.textRequest = response.payload;

                    //$http({
                    //        method: 'POST',
                    //        url: "/WebServiceStatistics.asmx/GetTextStatistics",
                    //        dataType: 'json',
                    //        data: "{paragraph:'WELCOME TO ERIC THE APPLE OF MY EYE' , filter: 'ABCDEFG'   }",                          
                    //        headers: { 'Content-Type': 'application/json; charset=utf-8' }

                    //    }).success(function (response) {

                    //        $scope.textResponse = response.payload;

                    //    }).error(function (data, status, headers, config) {

                    //        alert(data);
                    //        alert(status);
                    //        alert(headers);
                    //        alert(config);

                    //        $scope.textResponse = "ERROR";
                    //    });
                 
                    alert('bbb');



                }).error(function (data, status, headers, config) {
                    alert('error');
                }); //WEB SERVICE


                
            }; // CALL WEB SERVICE


            $scope.CallWebService();

        }); //CONTROLLER

    </script>
</head>
<body>

<form id="textstatisticsANGULAR" runat="server">


 <div>

<textarea id="txFilter">ZORK ADVENTURE</textarea>
     

<textarea id="txRequest" ng-model="textRequest"  ng-controller="myController">

</textarea>

 <textarea id="txResult" ng-model="textResponse"  ng-controller="myController">
 RESULT RESULT RESULT
 </textarea>

</div>
</form>
</body>
</html>
