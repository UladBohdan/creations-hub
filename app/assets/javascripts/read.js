app.controller('ReadCtrl', ['$scope', function ($scope) {
    $scope.textToRead = "nothing to read";

    $scope.creation = '';
    $scope.chapter = '';

    $scope.textSize = '';
    $scope.pageWidth = '';

    $scope.changeWidth = function(width) {
        $scope.pageWidth = "page" + width;
        if (storageAvailable()) {
            localStorage.setItem("page_width", $scope.pageWidth);
        }
    };

    $scope.resize = function(size) {
        if (size == "large") {
            $scope.textSize = "read-large";
        } else if (size == "medium") {
            $scope.textSize = "";
        } else if (size == "small") {
            $scope.textSize = "read-small";
        }
        if (storageAvailable()) {
            localStorage.setItem("text_size", $scope.textSize);
        }
    };

    function storageAvailable() {
        return !(typeof(Storage) == "undefined");
    }

    $scope.initSettings = function() {
        if (storageAvailable()) {
            $scope.textSize = localStorage.getItem("text_size");
            $scope.pageWidth = localStorage.getItem("page_width");
            localStorage.setItem("creation" + $scope.creation, $scope.chapter);
        }
    }

}]);