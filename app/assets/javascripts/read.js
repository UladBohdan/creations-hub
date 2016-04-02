app.controller('ReadCtrl', ['$scope', function ($scope) {
    $scope.textToRead = "nothing to read";

    $scope.currentState = '';
    $scope.currentWidth = '';

    $scope.textSize = '';
    $scope.pageWidth = '';

    $scope.changeWidth = function(width) {
        $scope.pageWidth = "page" + width;
        refreshStyling();
    };

    $scope.resize = function(size) {
        if (size == "large") {
            $scope.textSize = "read-large";
        } else if (size == "medium") {
            $scope.textSize = "";
        } else if (size == "small") {
            $scope.textSize = "read-small";
        }
        refreshStyling();
    };

    function refreshStyling() {
        $scope.currentState = $scope.textSize;
        $scope.currentWidth = $scope.pageWidth;
    }

}]);