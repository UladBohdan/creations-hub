app = angular.module('CreationsHub', [
    'ui.bootstrap',
    'ngFileUpload',
    'ngTagsInput',
    'angular-jqcloud',
    'ngCookies'
]);

app.config([
    "$httpProvider", function($httpProvider) {
        $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
}]);

app.controller('NavBarCtrl', ['$scope', function ($scope) {
    $scope.isCollapsed = true;
    $scope.currentUserId = "";
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