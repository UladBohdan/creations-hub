app = angular.module('CreationsHub', [
    'ui.bootstrap',
    'ngFileUpload'
]);

app.config([
    "$httpProvider", function($httpProvider) {
        $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
    }
]);

app.controller('NavBarCtrl', ['$scope',
    function ($scope) {
        $scope.isCollapsed = true;
        $scope.currentUserId = "";
    }
]);

app.controller('DropdownCtrl',
    function ($scope) {
        $scope.categoryOpened = false;
        $scope.sortOpened = false;
        $scope.limitOpened = false;
        $scope.currentSort = "any";
        $scope.currentCategory = "all";
        $scope.currentLimit = "6";
    }
);

app.controller("UserCtrl",
    function ($scope) {
        $scope.mode = "creations";
        $scope.creationsClass = "active";
        $scope.badgesClass = "";

        $scope.switchMode = function() {
            $scope.creationsClass = ($scope.mode == "creations" ? "active" : "");
            $scope.badgesClass = ($scope.mode == "badges" ? "active" : "");
        }
    }
);