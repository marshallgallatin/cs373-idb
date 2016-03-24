
var irdbApp = angular.module('irdbApp', ['ngRoute']);

// configure our routes
irdbApp.config
(
    function($routeProvider) 
    {
        $routeProvider
            // route for the home page
            .when('/', 
            {
                templateUrl : 'splash.html',
            })

            // route for the about page
            .when('/about', 
            {
                templateUrl : 'about.html',
            });
    }
);


function HeaderController($scope, $location) 
{ 
    $scope.isActive = function (viewLocation) 
    { 
        return viewLocation === $location.path();
    };
}
