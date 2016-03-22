'use strict';

/**
 * @ngdoc service
 * @name basketCaseApp.tag
 * @description
 * # tag
 * Service in the basketCaseApp.
 */
angular.module('basketCaseApp')
  .service('tag', function ($resource, auth) {
    return $resource(
      'https://ettdvfyrahundrafemtio-api-jc222fi.c9users.io/api/v1/tags/:tag',
      {
        tag: '@tag'
      },
      {
        query: {
          method: 'GET',
          headers: {
            'X-auth-token': auth.getToken(),
            'Authorization':'Token token=' + auth.getKey()
          }
        }
      }
    );




  });
