app.controller('ImageUploaderCtrl', ["$scope", 'Upload',
    function ($scope, $upload) {

        $scope.cloud = "http://res.cloudinary.com/dhgy4yket/image/upload/v1459658412/default_user_image_vlvdyg.png";
        $scope.message_edit = 'FILE_NOT_CHOSEN_EDIT';
        $scope.message_new = 'FILE_NOT_CHOSEN_NEW';
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
                $scope.message_edit = 'UPLOAD_SUCCESS_EDIT';
                $scope.message_new = 'UPLOAD_SUCCESS_NEW';
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