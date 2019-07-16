angular.module('yapp')

.service('Pub', ['$resource', 'config', function($resource, config){
  return $resource(config.server_address + '/api/pubs/:id', {id: '@id'},{
    update: {
      method: 'PUT'
    }
  });
}]);
