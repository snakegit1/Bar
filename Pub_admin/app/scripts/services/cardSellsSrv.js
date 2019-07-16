angular.module('yapp')

.service('cardSellsSrv', ['$resource', 'config', function($resource, config){
  return $resource(config.server_address + '/api/orders/:id', {id: '@id'},{
    update: {
      method: 'PUT'
    }
  });
}]);
