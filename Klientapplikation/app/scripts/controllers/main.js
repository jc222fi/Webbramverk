'use strict';

/**
 * @ngdoc function
 * @name basketCaseApp.controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the basketCaseApp
 */
angular.module('basketCaseApp')
  .controller('MainCtrl', function ( $scope, auth, tag ) {
    $scope.isLoggedIn = function() {
      console.log(auth.isLoggedIn());
      return auth.isLoggedIn();
    };
    $scope.logIn = function(){
      console.log('Logging in...');
      auth.tryAuth();
    };
    $scope.tags = tag.query();
  });
