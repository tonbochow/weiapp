var AlbumModule = angular.module("baby", []);
AlbumModule.controller("AlbumAddController", function ($scope, $http) {
    $(function () {
        $('#file_upload').uploadify({
            'formData': {
                'timestamp': '<?php echo $timestamp;?>',
                'token'     : '<?php echo md5('unique_salt' . $timestamp);?>'
            },
            'buttonText': '选择相册封面图片',
            'swf': '__COMMON__/uploadify/uploadify.swf',
            'onUploadSuccess': function (file, data, response) {
                var obj = eval('(' + data + ')');
                if (obj.status) {
                    $scope.album.thumb_url = obj.thumb_url;
                    $('#previmg').attr('src', obj.thumb_url);
                } else {
                    alert(obj.info);
                }

            },
            'uploader': '/Admin/Album/upload'
        });
    });
    $scope.statusModel = [{
            id: 1,
            statusName: '公开'
        }, {
            id: 0,
            statusName: '不公开'
        }];
    $scope.submitForm = function () {
        $http({
            method: "POST",
            url: "/Admin/Album/add",
            data: $.param($scope.album),
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        }).success(function (data) {
            if (data.status) {
                $scope.success = data.success;
                window.location.href = '/Admin/Album/index';
            } else {
                $scope.message = data.message;
            }
        });
    };
});