// create the module and name it scotchApp
// also include ngRoute for all our routing needs
var irdbApp = angular.module('irdbApp', ['ngRoute']);

// configure our routes
irdbApp.config(function($routeProvider) {
    $routeProvider

        // route for the home page
        .when('/', {
            templateUrl : 'splash.html',
            controller  : 'mainController'
        })

        // route for the about page
        .when('/about', {
            templateUrl : 'about.html',
            controller  : 'aboutController'
        });
});

// create the controller and inject Angular's $scope
irdbApp.controller('mainController', function($scope) {
    // create a message to display in our view
    $scope.message = 'Everyone come and see how good I look!';
});

irdbApp.controller('aboutController', function($scope) {
    $scope.message = 'Look! I am an about page.';
});

