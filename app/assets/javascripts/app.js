app = angular.module('CreationsHub', ['ui.bootstrap']);

app.controller('NavBarCtrl', ['$scope',
    function ($scope) {
        $scope.isCollapsed = true;
        $scope.currentUserId = "";
    }
]);