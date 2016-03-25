app.controller('EditCreationCtrl', ['$scope', '$http',
    function ($scope, $http) {

        $scope.chapters = [];
        $scope.creation_id = "";
        $scope.currentChapterMarkdown = "hohoho";

        $scope.receiveChapters = function() {
            $http({
                url: "/creation/" + $scope.creation_id + "/chapter",
                format: "json",
                method: "GET"
            }).then( function successCallback(response) {
                angular.copy(response.data, $scope.chapters);
            }, function errorCallback(response) {
                alert("failed:(");
            });
        };

        $scope.saveAllChanges = function() {

        };

        $scope.addNewChapter = function() {
            $scope.chapters.push({title: "new chapter!!!"});
        };
    }
]);