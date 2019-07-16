angular.module('yapp')

.service('Drink', ['$resource', 'config', function($resource, config){
  return $resource(config.server_address + '/api/drinks/:id', {id: '@id'},{
    update: {
      method: 'PUT'
    }
  });
}]);
