app = angular.module('CreationsHub', ['ui.bootstrap']);

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