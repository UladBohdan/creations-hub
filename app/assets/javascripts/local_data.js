app.controller("LocalDataCtrl", ['$scope', '$location', '$window', '$cookies', function($scope, $location, $window, $cookies) {
    $scope.style = "";
    $scope.lang = "";

    $scope.switchStyle = function() {
        $scope.style = ($scope.style == "light" ? "dark" : "light");
        if (storageAvailable()) {
            localStorage.setItem("Style", $scope.style);
        }
    };

    $scope.switchLanguage = function(lang) {
        var old_lang = $scope.lang;
        $scope.lang = lang;
        if (old_lang != $scope.lang) {
            $cookies.put("locale", $scope.lang, {path: "/"});
            if (storageAvailable()) {
                localStorage.setItem("language_changed", "true");
            }
            $window.location.href = buildBaseUrl();
        }
    };

    function loadLocalData() {
        if (storageAvailable()) {
            $scope.style = localStorage.getItem("Style") || "light";
            $scope.lang = $cookies.get("locale");
        }
    }

    function storageAvailable() {
        return !(typeof(Storage) == "undefined");
    }

    function buildBaseUrl() {
        return $location.protocol() + '://' + $location.host() + ':' + $location.port() + window.location.pathname;
    }

    loadLocalData();
}]);