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

        $scope.removeComment = function(commentId) {
            $http({
                url: "/comment/remove",
                format: "json",
                method: "GET",
                params: {comment_id: commentId, creation_id: $scope.creation_id}
            }).then(function successCallback(response) {
                angular.copy(response.data, $scope.comments);
            }, function errorCallback(response) {
                alert("failed.");
            });
        }
    }
]);