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

app.controller('CommentsCtrl', ['$scope', '$http',
   function ($scope, $http) {

       $scope.new_comment = "";
       $scope.creation_id = "";
       $scope.comments = [];

       $scope.sendComment = function(add_comment) {
           $http({
               url: "/comment",
               format: "json",
               method: "GET",
               params: {add_comment: add_comment, text: $scope.new_comment, creation_id: $scope.creation_id}
           }).then(function successCallback(response) {
               angular.copy(response.data, $scope.comments);
               $scope.new_comment = "";
           }, function errorCallback(response) {
               alert("failed.");
           });
       };
   }
]);