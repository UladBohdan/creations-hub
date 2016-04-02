app.controller('EditCreationCtrl', ['$scope', '$http', function ($scope, $http) {

    $scope.chapters = [];
    $scope.creation_id = "";
    $scope.currentChapterId = "";
    $scope.currentChapterText = "";
    $scope.currentChapterTitle = "";
    $scope.textBeforeEditing = "";
    $scope.titleBeforeEditing = "";

    $scope.strTags = "";
    $scope.strAllTags = "";

    $scope.tags = [];
    $scope.allTags = [];

    $scope.arrayOfTags = function() {
        var response = [];
        for (var i = 0; i < $scope.tags.length; i++) {
            response.push($scope.tags[i].text);
        }
        document.getElementById("railsTags").value = response;
    };

    $scope.loadTags = function(query) {
        var tagsToReturn = [];
        var pattern = new RegExp("^(" + query + ")");
        $scope.allTags.forEach(
            function(item) {
                if (pattern.test(item.text)) {
                    tagsToReturn.push(item.text);
                }
        });
        return tagsToReturn;
    };

    $scope.initTags = function() {
        $scope.tags = JSON.parse($scope.strTags);
        $scope.allTags = JSON.parse($scope.strAllTags);
    };

    $scope.receiveChapters = function() {
        $http({
            url: "/creation/" + $scope.creation_id + "/chapter",
            format: "json",
            method: "GET"
        }).then( function successCallback(response) {
            angular.copy(response.data, $scope.chapters);
            sortChapters();
            $scope.currentChapterId = $scope.chapters[0].id;
            chooseChapter();
        }, function errorCallback(response) {
            alert("failed:(");
        });
    };

    function sortChapters() {
        $scope.chapters.sort(
            function (a, b) {
                return a.position - b.position;
            }
        );
    }

    $scope.updateChapter = function() {
        $http({
            url: "/creation/" + $scope.creation_id + "/chapter/"
                    + $scope.currentChapterId,
            format: "json",
            method: "PUT",
            data: { text: $scope.currentChapterText, title: $scope.currentChapterTitle }
        }).then( function successCallback(response) {
            angular.copy(response.data, $scope.chapters);
            chooseChapter();
        }, function errorCallback(response) {
            alert("failed:(");
        });
    };

    $scope.updateChapterOrder = function() {
        var new_order = [];
        $scope.chapters.forEach(
            function(chapter, index) {
                new_order[index] = chapter.id;
            }
        );
        $http({
            url: "/creation/" + $scope.creation_id + "/chapter/reorder",
            format: "json",
            method: "POST",
            data: { new_order: new_order }
        }).then( function successCallback(response) {
            //alert("ok");
        }, function errorCallback(response) {
            alert("failed:(");
        });
    };

    $scope.removeChapter = function() {
        if (confirm("Are you sure? This cannot be undone")) {
            $http({
                url: "/creation/" + $scope.creation_id + "/chapter/" + $scope.currentChapterId,
                format: "json",
                method: "DELETE"
            }).then( function successCallback(response) {
                angular.copy(response.data, $scope.chapters);
                $scope.currentChapterId = $scope.chapters[0].id;
                chooseChapter();
            }, function errorCallback(response) {
                alert("failed:(");
            });
        }
    };

    $scope.changeWorkingChapter = function(id) {
        $scope.currentChapterId = id;
        chooseChapter();
    };

    $scope.addNewChapter = function() {
        $http({
            url: "/creation/" + $scope.creation_id + "/chapter",
            format: "json",
            method: "POST",
            data: {position: $scope.chapters.length}
        }).then( function successCallback(response) {
            angular.copy(response.data, $scope.chapters);
            $scope.currentChapterId = $scope.chapters[$scope.chapters.length-1].id;
            chooseChapter();
        }, function errorCallback(response) {
            alert("failed:(");
        });
    };

    function findChapterById(id) {
        for (var i = 0; i < $scope.chapters.length; i++) {
            if ($scope.chapters[i].id == id) {
                return $scope.chapters[i];
            }
        }
        return 0;
    }

    function chooseChapter() {
        $scope.currentChapterText = findChapterById($scope.currentChapterId).text;
        $scope.currentChapterTitle = findChapterById($scope.currentChapterId).title;
        $scope.textBeforeEditing = $scope.currentChapterText;
        $scope.titleBeforeEditing = $scope.currentChapterTitle;
    }
}]);