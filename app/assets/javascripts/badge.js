
/*
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
        alert("checking badges " + badgeName);
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
                alert("no new badges at the moment");
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
}); */