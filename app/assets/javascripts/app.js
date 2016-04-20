app = angular.module('CreationsHub', [
    'ui.bootstrap',
    'ngFileUpload',
    'ngTagsInput',
    'angular-jqcloud',
    'ngCookies',
    'dndLists',
    'textAngular',
    'pascalprecht.translate'
]);

app.config([
    "$httpProvider", function($httpProvider) {
        $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
}]);

app.controller('NavBarBadgeCtrl', ['$scope', '$http', '$uibModal', function ($scope, $http, $uibModal) {
    $scope.isCollapsed = true;

    $scope.searchQuery = "";
    $scope.searchResults = [];
    $scope.emptyResult = true;
    $scope.searchBoxVisible = false;

    $scope.doSearch = function() {
        $http({
            url: "/search",
            format: "json",
            method: "GET",
            params: { query: $scope.searchQuery }
        }).then( function successCallback(response) {
            angular.copy(response.data, $scope.searchResults);
            $scope.searchBoxVisible = true;
            $scope.emptyResult = ($scope.searchResults.length == 0);
        }, function errorCallback(response) {
            alert("failed:(");
        });
    };

    $scope.closeSearchBox = function() {
        $scope.searchResults = [];
        $scope.emptyResult = true;
        $scope.searchBoxVisible = false;
        $scope.searchQuery = "";
    };

    $scope.newBadge = [];

    $scope.open = function() {
        $uibModal.open({
            animation: true,
            templateUrl: 'badge_modal',
            controller: 'ModalInstanceCtrl',
            size: 'sm',
            resolve: {
                newBadge: function () {
                    return $scope.newBadge;
                }
            }
        });
    };

    $scope.checkBadgesPending = function(badgeName) {
        if (badgeName == "polyglot") {
            if (storageAvailable()) {
                if (localStorage.getItem("language_changed") != "true")
                    return false;
            }
        }
        $scope.badgeFound = false;
        $http({
            url: "/badges",
            format: "json",
            method: "GET",
            params: { name: badgeName }
        }).then( function successCallback(response) {
            angular.copy(response.data, $scope.newBadge);
            if ($scope.newBadge.exists == true) {
                $scope.open();
            } else {
                // alert("no new badges at the moment");
            }
        }, function errorCallback(response) {
            //alert("failed:( badge");
        });
    };

    function storageAvailable() {
        return !(typeof(Storage) == "undefined");
    }

}]);

app.controller('ModalInstanceCtrl', ['$scope', '$uibModalInstance', 'newBadge', function ($scope, $uibModalInstance, newBadge) {

    $scope.newBadge = newBadge;

    $scope.cancel = function () {
        $uibModalInstance.close();
    };
}]);

app.controller("UserCtrl", ['$scope', function ($scope) {
    $scope.mode = "creations";
    $scope.creationsClass = "active";
    $scope.badgesClass = "";

    $scope.switchMode = function() {
        $scope.creationsClass = ($scope.mode == "creations" ? "active" : "");
        $scope.badgesClass = ($scope.mode == "badges" ? "active" : "");
    }
}]);