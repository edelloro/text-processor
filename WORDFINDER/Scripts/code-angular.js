var app = angular.module("myApp", []);

app.controller('myController', function ($scope, $http) {

    $scope.textFilter = "ZORK ADVENTURE";
    $scope.textResponse = [];
    $scope.myFunct = function (keyEvent) {


        var myrequest = $scope.textRequest;
        var myfilter = $scope.textFilter;

        myrequest = myrequest.replace(/'/g, "\\'");
        myrequest = myrequest.replace(/(\r\n|\n|\r)/gm, " ");
        myfilter = myfilter.replace(/(\r\n|\n|\r)/gm, " ");

        $http({
            method: 'POST',
            url: "WEBSERVICE/WebServiceStatistics.asmx/GetTextStatistics",
            dataType: 'json',
            data: { 'paragraph': escape(myrequest), 'filter': escape(myfilter) },
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
            method: 'POST',
            url: 'WEBSERVICE/WebServiceStatistics.asmx/GetZorkText',
            dataType: 'json',
            data: {}, //SEND JSON RETURN JSON
            //data:   {name:'TEST123'}             
            contentType: 'application/json; charset=utf-8'
        }).success(function (response) {
            var data = response.d;
            $scope.textRequest = data.payload;

            $http({
                method: 'POST',
                url: "WEBSERVICE/WebServiceStatistics.asmx/GetTextStatistics",
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

        }).error(function (data, status, headers, config) { }); //$http
    }; // CALL WEB SERVICE

    $scope.CallWebServiceInit();

}); //CONTROLLER