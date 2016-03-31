app.controller('TagCloudCtrl', function($scope) {
    $scope.words = [];
    $scope.strTags = "";

    $scope.initTags = function() {
        $scope.words = JSON.parse($scope.strTags);
    };
});