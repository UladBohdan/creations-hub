app.controller('ImageUploaderCtrl', ["$scope", 'Upload',
    function ($scope, $upload) {

        $scope.cloud = "";
        $scope.message_edit = "File not chosen. Your profile image won't be changed";
        $scope.message_new = "File not chosen. Your profile will be created without profile image";
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
                $scope.message_edit = "Image was successfully uploaded! Update your profile with you current password.";
                $scope.message_new = "Image was successfully uploaded!";
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