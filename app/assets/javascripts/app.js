app = angular.module('CreationsHub', [
    'ui.bootstrap',
    'ngFileUpload',
    'ngTagsInput',
    'angular-jqcloud'
]);

app.config([
    "$httpProvider", function($httpProvider) {
        $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
    }
]);

app.controller('NavBarCtrl', ['$scope', function ($scope) {
    $scope.isCollapsed = true;
    $scope.currentUserId = "";
}]);

app.controller('DropdownCtrl', function ($scope) {
    $scope.categoryOpened = false;
    $scope.sortOpened = false;
    $scope.limitOpened = false;
    $scope.currentSort = "any";
    $scope.currentCategory = "all";
    $scope.currentLimit = "6";
});

app.controller("UserCtrl", function ($scope) {
    $scope.mode = "creations";
    $scope.creationsClass = "active";
    $scope.badgesClass = "";

    $scope.switchMode = function() {
        $scope.creationsClass = ($scope.mode == "creations" ? "active" : "");
        $scope.badgesClass = ($scope.mode == "badges" ? "active" : "");
    }
});

app.controller("LocalDataCtrl", function($scope) {
    $scope.style = "";

    $scope.switchStyle = function() {
        $scope.style = ($scope.style == "light" ? "dark" : "light");
        if (storageAvailable()) {
            localStorage.setItem("Style", $scope.style);
        }
    };

    function loadLocalData() {
        if (storageAvailable()) {
            $scope.style = localStorage.getItem("Style") || "light";
        }
    }

    function storageAvailable() {
        return !(typeof(Storage) == "undefined");
    }

    loadLocalData();
});