var TryModule = angular.module("weiapp_try", []);
TryModule.controller("TryController", function($scope, $http) {
    $scope.submitForm = function() {
        $('.submit').attr('disabled', 'true');
        $http({
            method: "POST",
            url: "/Home/Try/index",
            data: $.param($scope.try_data),
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}
        }).success(function(data) {
            if (data.status) {
                $('#dialog_content').text(data.info);
                $("#dialog").dialog({modal: true});
                setTimeout("result(" + data.status + ")", 1000);
            } else {
                $('#dialog_content').text(data.info);
                $("#dialog").dialog({modal: true});
                setTimeout("result(" + data.status + ")", 1000);
            }
        });
    };
});

function result(status) {
    $("#dialog").dialog("close");
    if (status) {
        window.location.href = '/Home/Index/index';
    } else {
        window.location.reload();
    }
}