app = angular.module('CreationsHub', [
    'ui.bootstrap',
    'ngFileUpload',
    'ngTagsInput',
    'angular-jqcloud',
    'ngCookies',
    'dndLists',
    'textAngular'
]);

app.config([
    "$httpProvider", function($httpProvider) {
        $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
}]);

app.controller('NavBarCtrl', ['$scope', '$http', function ($scope, $http) {
    $scope.isCollapsed = true;
    $scope.currentUserId = "";

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
    }

}]);

app.controller("UserCtrl", function ($scope) {
    $scope.mode = "creations";
    $scope.creationsClass = "active";
    $scope.badgesClass = "";

    $scope.switchMode = function() {
        $scope.creationsClass = ($scope.mode == "creations" ? "active" : "");
        $scope.badgesClass = ($scope.mode == "badges" ? "active" : "");
    }
});