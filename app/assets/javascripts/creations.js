app.controller('CreationsCtrl', ['$scope', '$http',
    function ($scope, $http) {

        $scope.creations = [];

        $scope.loadCreations = function(params) {
            $http({
                url: "/creation",
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