angular.module('yapp')

.service('PubDrink', ['$resource', 'config', function($resource, config){
  return $resource(config.server_address + '/api/pub_drinks/:id', {id: '@id'},{
    update: {
      method: 'PUT'
    }
  });
}]);
