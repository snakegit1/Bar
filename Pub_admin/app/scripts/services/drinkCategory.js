angular.module('yapp')

.service('DrinkCategory', ['$resource', 'config', function($resource, config){
  return $resource(config.server_address + '/api/drink_categories/:id', {id: '@id'},{
    update: {
      method: 'PUT'
    }
  });
}]);
