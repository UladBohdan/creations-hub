app.controller('TagCloudCtrl', ['$scope', function($scope) {
    $scope.words = [];
    $scope.strTags = "";

    $scope.initTags = function() {
        $scope.words = JSON.parse($scope.strTags);
    };
}]);