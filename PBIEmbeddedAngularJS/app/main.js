(function () {
    'use strict';

    angular
        .module('app')
        .controller('ReportsController', reportrender);

    function reportrender($scope, $http) {
        $scope.counter = 0;
        $scope.visrender = false;
        $scope.vislogin_sumbitrender = true;

        $scope.embedToken = "";
        $scope.embedUrl = "";
        $scope.reportId = "";
        $scope.username = "User A";
        $scope.CustomerA = "";$scope.CustomerB = "";
        $scope.CustomerC = "";$scope.CustomerD = "";
        $scope.CustomerE = "";$scope.CustomerF = "";
        $scope.CustomerG = "";
        $scope.roles = "";


        $scope.reportlist = function ()
        {
            $http.get('http://localhost:1184/api/report').
            success(function (data, status, headers, config) {
            $scope.reports = data;
            $scope.counter = 0;
            alert($scope.reports[0].name);
            $scope.selectedReport = $scope.reports[0].id;

            }).error(function (data, status, headers, config) {
              alert("Error : read list of reports from WebApi ");
            });

        }

        var reportEmbedToken =  function (rid,username,roles) {
            var token = "";
            $http.get('http://localhost:1184/api/report' + '/' + rid + '/' + username + '/' + roles).
            success(function (data, status, headers, config) {
                token = data;
                alert(token);
                $scope.embedUrl = token;
                $scope.visrender = true;
                $scope.vislogin_sumbitrender = false;
                $scope.reportId = $scope.selectedReport;
                $scope.embedUrl = 'https://embedded.powerbi.com/appTokenReportEmbed?reportId=' + $scope.reportId;
                var divreportu = document.getElementById("Report");
                divreportu.attributes.getNamedItem("powerbi-access-token").value = token;
                powerbi.embed(divreportu, { embedUrl: 'https://embedded.powerbi.com/appTokenReportEmbed?reportId=' + $scope.reportId, accessToken: token });
                powerbi.init();

            }).error(function (data, status, headers, config) {
                alert("Error : get embed token for report from WebApi");
                token = "";
            });

            //return token;
        }

        $scope.addCounter = function() {
            updateCounter();
        };
        $scope.validate =  function () {
            updateCounter();
            if ($scope.counter > 10)
                alert("You reached maximum limit of report sessions.");
            else
            {
                //call webapi for embedToken
                prepareRolesParameter();
                $scope.embedToken = reportEmbedToken($scope.selectedReport, $scope.username, $scope.roles);
            }
        };
        var updateCounter = function () {
           $scope.counter++;
        };

        var prepareRolesParameter = function () {
            var roles = "";
            if ($scope.CustomerA == true)
                roles = "role_custA";
            if ($scope.CustomerB == true) {
                if (roles.trim() != "")
                    roles = roles + "~role_custB";
                else
                    roles = "role_custB";
            }
            if ($scope.CustomerC == true) {
                if (roles.trim() != "")
                    roles = roles + "~role_custC";
                else
                    roles = "role_custC";
            }
            if ($scope.CustomerD == true) {
                if (roles.trim() != "")
                    roles = roles + "~role_custD";
                else
                    roles = "role_custD";
            }
            if ($scope.CustomerE == true) {
                if (roles.trim() != "")
                    roles = roles + "~role_custE";
                else
                    roles = "role_custE";
            }
            if ($scope.CustomerF == true) {
                if (roles.trim() != "")
                    roles = roles + "~role_custF";
                else
                    roles = "role_custF";
            }
            if ($scope.CustomerG == true) {
                if (roles.trim() != "")
                    roles = roles + "~role_custG";
                else
                    roles = "role_custG";
            }
            $scope.roles= roles;
        };

    };


})();
