'use strict';

/**
 * @ngdoc function
 * @name basketCaseApp.controller:AuthCtrl
 * @description
 * # AuthCtrl
 * Controller of the basketCaseApp
 */
angular.module('basketCaseApp')
  .controller('AuthCtrl', function ($location, auth) {
    auth.extractTokenFromUrl();
    $location.path('/');
  });
