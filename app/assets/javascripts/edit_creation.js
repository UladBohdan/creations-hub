app.controller('EditCreationCtrl', ['$scope', '$http',
    function ($scope, $http) {

        $scope.chapters = [];
        $scope.creation_id = "";
        $scope.currentChapterId = 0;
        $scope.currentChapterText = "";
        $scope.currentChapterTitle = "";
        $scope.textBeforeEditing = "";
        $scope.titleBeforeEditing = "";

        $scope.receiveChapters = function() {
            $http({
                url: "/creation/" + $scope.creation_id + "/chapter",
                format: "json",
                method: "GET"
            }).then( function successCallback(response) {
                angular.copy(response.data, $scope.chapters);
                $scope.currentChapterId = chapters[0].id;
                chooseChapter();
            }, function errorCallback(response) {
                alert("failed:(");
            });
        };

        $scope.saveAllChanges = function() {

        };

        $scope.updateChapter = function() {
            $http({
                url: "/creation/" + $scope.creation_id + "/chapter/"
                        + $scope.currentChapterId,
                format: "json",
                method: "PUT",
                params: { text: $scope.currentChapterText, title: $scope.currentChapterTitle }
            }).then( function successCallback(response) {
                angular.copy(response.data, $scope.chapters);
            }, function errorCallback(response) {
                alert("failed:(");
            });
        };

        $scope.changeWorkingChapter = function(id) {
            $scope.currentChapterId = id;
            chooseChapter();
        };

        $scope.addNewChapter = function() {
            $scope.chapters.push({title: "new chapter!!!"});
        };

        function findChapterById(id) {
            for (var i = 0; i < $scope.chapters.length; i++) {
                if ($scope.chapters[i].id == id) {
                    return $scope.chapters[i];
                }
            }
        }

        function chooseChapter() {
            $scope.currentChapterText = findChapterById($scope.currentChapterId).text;
            $scope.currentChapterTitle = findChapterById($scope.currentChapterId).title;
            $scope.textBeforeEditing = $scope.currentChapterText;
            $scope.titleBeforeEditing = $scope.currentChapterTitle;
        }
    }
]);