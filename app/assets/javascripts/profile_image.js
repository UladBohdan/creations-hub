app.controller('ImageUploaderCtrl', ["$scope", 'Upload',
    function ($scope, $upload) {

        $scope.cloud = "";
        $scope.message_edit = { en: "File not chosen. Your profile image won't be changed",
                                be: "Файл не абраны. Выява профіля не зменіцца" };
        $scope.message_new = { en: "File not chosen. Your profile will be created without profile image",
                               be: "Файл не абраны. Профіль будзе створаны без выявы" };
        $scope.status = 0;

        $scope.uploadFile = function() {
            var local_image = event.target.files[0];
            $upload.upload({
                url: "https://api.cloudinary.com/v1_1/dhgy4yket/upload",
                data: {
                    upload_preset: "mjqs75rz",
                    tags: "creation_profile_images",
                    authorization: undefined,
                    file: local_image
                }
            }).success(function (data, status, headers, config) {
                $scope.cloud = data.url;
                $scope.message_edit = { en: "Image was successfully uploaded! Update your profile with you current password.",
                                        be: "Выява была паспяхова загружаная! Абнавіце Ваш профіль з дапамогай пароля." };
                $scope.message_new = { en: "Image was successfully uploaded!",
                                       be: "Выява была паспяхова загружаная." };
                $scope.status = 1;
            }).error(function (data, status, headers, config) {
                alert("error:(");
            });
        };
    }
]);

app.directive('imageUploadDr', function() {
    return {
        restrict: 'A',
        link: function (scope, element, attrs) {
            var onChangeFunc = scope.$eval(attrs.imageUploadDr);
            element.bind('change', onChangeFunc);
        }
    };
});