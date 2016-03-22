'use strict';

/**
 * @ngdoc overview
 * @name basketCaseApp
 * @description
 * # basketCaseApp
 *
 * Main module of the application.
 */
angular
  .module('basketCaseApp', [
    'ngAnimate',
    'ngCookies',
    'ngResource',
    'ngRoute',
    'ngSanitize',
    'ngTouch',
    'LocalStorageModule'
  ])
  .config(function ($routeProvider) {
    $routeProvider
      .when('/', {
        templateUrl: 'views/main.html',
        controller: 'MainCtrl',
        controllerAs: 'main'
      })
      .when('/auth/github', {
        templateUrl: 'views/main.html',
        controller: 'AuthCtrl',
        controllerAs: 'authCtrl'
      })
      .when('/about', {
        templateUrl: 'views/about.html',
        controller: 'AboutCtrl',
        controllerAs: 'about'
      })
      .otherwise({
        redirectTo: '/'
      });
  });
