angular.module('yapp')

.service('User', ['$resource','config', function($resource, config){
  return $resource(config.server_address + '/api/users/:id', {id: '@id'},{
    update: {
      method: 'PUT'
    }
  });
}]);
