app.controller('DropdownCtrl', function ($scope) {
    $scope.categoryOpened = false;
    $scope.sortOpened = false;
    $scope.limitOpened = false;

    $scope.currentSort = "any";
    $scope.currentCategory = "all";
    $scope.currentLimit = "six";
});
