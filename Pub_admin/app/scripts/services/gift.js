angular.module('yapp')

.service('Gift', ['$resource', 'config', function($resource, config){
  return $resource(config.server_address + '/api/gifts/:id', {id: '@id'},{
    update: {
      method: 'PUT'
    }
  });
}]);
