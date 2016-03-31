app = angular.module('CreationsHub', [
    'ui.bootstrap',
    'ngFileUpload',
    'ngTagsInput'
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

app.controller("BadgeCtrl", ['$scope', '$uibModal', '$http', function($scope, $uibModal, $http) {

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
        //alert("checking");
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
                //alert("no new badges at the moment");
            }
        }, function errorCallback(response) {
            alert("failed:( badge");
        });
    };

}]);

app.controller('ModalInstanceCtrl', function ($scope, $uibModalInstance, newBadge) {

    $scope.newBadge = newBadge;

    $scope.cancel = function () {
        $uibModalInstance.close();
    };
});