app.controller('DropdownCtrl', function ($scope) {
    $scope.categoryOpened = false;
    $scope.sortOpened = false;
    $scope.limitOpened = false;

    $scope.currentSort = "any";
    $scope.currentCategory = "all";
    $scope.currentLimit = "six";

    $scope.t_currentSort = "";
    $scope.t_currentCategory = "";
    $scope.t_currentLimit = "";

    $scope.translate = function() {
        $scope.t_currentSort = translations[$scope.lang][$scope.currentSort];
        $scope.t_currentCategory = translations[$scope.lang][$scope.currentCategory];
        $scope.t_currentLimit = translations[$scope.lang][$scope.currentLimit];
    };

    var translations = {
        en: {
            fiction: "Fiction",
            fantasy: "Fantasy",
            comedy: "Comedy",
            science: "Science",
            cooking: "Cooking",
            programming: "Programming",
            others: "Others",
            all: "all",
            recently_created: "Recently created",
            recently_updated: "Recently updated",
            most_rated: "Most rated",
            any: "any",
            four: "4",
            six: "6",
            ten: "10",
            no_limit: "no limit"
        },
        be: {
            fiction: "Фантастыка",
            fantasy: "Фэнтэзі",
            comedy: "Камедыя",
            science: "Навука",
            cooking: "Кухарства",
            programming: "Праграмаванне",
            others: "Іншае",
            all: "Усе",
            recently_created: "Нядаўна створаныя",
            recently_updated: "Нядаўна абноўленыя",
            most_rated: "Найлепш ацэненыя",
            any: "Любыя",
            four: "4",
            six: "6",
            ten: "10",
            no_limit: "Без абмежаванняў"
        }
    };

    $scope.translate();

});
