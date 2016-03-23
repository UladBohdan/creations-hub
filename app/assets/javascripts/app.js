app = angular.module('CreationsHub', ['ui.bootstrap']);

app.controller('NavBarCtrl', ['$scope',
    function ($scope) {
        $scope.isCollapsed = true;
    }
]);

app.controller('CreationsCtrl', ['$scope', '$http',
    function ($scope, $http) {

        $scope.creations = [];

        $scope.loadCreations = function(params) {
            $http({
                url: "/creations",
                format: "json",
                method: "GET",
                params: params
            }).then( function successCallback(response) {
                angular.copy(response.data, $scope.creations);
            }, function errorCallback(response) {
                alert("failed:(");
            });
        };

        $scope.loadCreations();
    }
]);
