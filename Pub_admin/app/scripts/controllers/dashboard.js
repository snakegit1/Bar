/**
 * @ngdoc function
 * @name yapp.controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of yapp
 */
angular.module('yapp')
  .controller('DashboardCtrl',
    ['$scope', '$stateParams', '$rootScope', '$state', '$resource', '$auth', '$location', 'Pub', 'Drink', 'PubDrink', '$uibModal',
    function($scope, $stateParams, $rootScope, $state, $resource, $auth, $location, Pub, Drink, PubDrink, $uibModal) {

    init();

    function init(){
      console.log('init dashboard ctrl');
    };

    $scope.signOut = function(){
    	$auth.signOut();
    	$location.path('/');
    };

    $scope.updatePub = function(){
        console.log('Updating pub info...');
        //$scope.pub.$update();
    };

    $scope.createPub = function(){
      $state.go('pub');
    };

    $scope.getDrinksFromCategory = function(selected_category) {
         var drinks = [];

         for (var i=0;i<$scope.drinks.length; i++){
            if ($scope.drinks[i].drink_category.name == selected_category)
                drinks.push($scope.drinks[i]);
         }

         return drinks;
    }

}]);
