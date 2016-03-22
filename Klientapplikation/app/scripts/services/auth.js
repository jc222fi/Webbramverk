'use strict';

/**
 * @ngdoc service
 * @name basketCaseApp.auth
 * @description
 * # auth
 * Service in the basketCaseApp.
 */
angular.module('basketCaseApp')
  .service('auth', function ($window, localStorageService) {

    var apiKey = '216a92f0887c3af13d749cbbeb7afe6440239f8cc1c13c9c';

    this.isLoggedIn = function() {

      console.log(localStorageService.get('token'));

      return localStorageService.get('token') !== '' && localStorageService.get('token') !== null;
    };
    this.tryAuth = function() {
      $window.location.href = 'https://ettdvfyrahundrafemtio-api-jc222fi.c9users.io/authenticate?callback=http://localhost:9000/#/auth/github';
    };
    this.extractTokenFromUrl = function() {
      var params;

      params = window.location.search;
      localStorageService.set('token', params.match(/\?auth_token=(.*)&/i));
      localStorageService.set('tokenExpires', params.match(/&token_expires=(.*)/i));
    };
    this.getToken = function() {
      return localStorageService.get('token');
    };
    this.getTokenExpires = function() {
      return localStorageService.get('tokenExpires');
    };
    this.getKey = function() {
      return apiKey;
    };
  });
