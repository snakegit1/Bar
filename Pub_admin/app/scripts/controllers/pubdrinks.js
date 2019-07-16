/**
 * @ngdoc function
 * @name yapp.controller:PubDrinkCtrl
 * @description
 * # PubDrinkCtrl
 * Controller of yapp
 */
angular.module('yapp')
  .controller('PubDrinkCtrl', function($http, config, $scope, $rootScope, $state, $stateParams, $auth, $location, Pub, Drink, PubDrink, $uibModal, $resource) {

    init();

    function init(){

      loadPubData();
      loadDrinksData();
    };

    function loadPubData(){

      Pub.query().$promise.then(function (results) {
        $rootScope.pubs = results;

        if ($stateParams.id != null){
          for(var i=0; i < results.length; i++){
            if (results[i].id == $stateParams.id){

              $scope.pub = results[i];
            }

          }

        }
        else {
          $scope.pub = results[0];
        }

        $scope.allPermissions = true;

      }, function(error) {
        $scope.pub = null;
      });
    };

    function loadDrinksData(){

        $scope.selected_category = 'Pisco';
        if ($scope.drink_categories == null)
          $scope.drink_categories = [];

        Drink.query().$promise.then(function (result) {
            //console.log(result);
            $scope.drinks = result;

            for (var i=0; i<$scope.drinks.length; i++){
                if ($scope.drink_categories.indexOf($scope.drinks[i].drink_category.name) == -1){
                    console.log($scope.drinks[i])
                    $scope.drink_categories.push($scope.drinks[i].drink_category.name)
                }
            }
            console.log('categorias');
            //test = $scope.drinks.filter('groupBy', 'drink_category.name');
            console.log($scope.drink_categories);

        });
    };

    $scope.disablePubDrink = function (PubDrinkId) {
      var params = {
        id: PubDrinkId,
      };

      $http.put(config.server_address + '/api/pub_drinks/enable_pub_category', params, {
        headers: $auth.retrieveData('auth_headers')
      })
      .then(function(results) {
        if (results.status === 200) {
          loadPubData();
          loadDrinksData();
        }
      })
      .finally(function(){

      });
    }

    $scope.openModal = function (pub, pub_drink) {
      loadDrinksData();
      if (pub_drink != null){

        PubDrink.get({id: pub_drink.id}).$promise.then(function(selected_pub_drink) {

          startModal($scope.drinks, pub, selected_pub_drink);

        }, function(errResponse) {
           console.log('Error!');
        });
      } else {
        console.log('Pub is ', pub)
        Drink.query().$promise.then(function (result) {
          startModal(result, pub, null);
        })

      }

   };


   function startModal(drinks, pub, selected_pub_drink){

     var modalInstance = $uibModal.open({
       animation: $scope.animationsEnabled,
       templateUrl: 'myModalContent.html',
       controller: 'ModalInstanceCtrl',
       resolve: {
         drinks: function () {
           return drinks;
         },
         selected_pub_drink: function () {
           return selected_pub_drink;
         },
         selected_pub: function() {
           return pub;
         }
       }
     });

     modalInstance.result.then(function () {
         loadPubData();
     }, function () {

     });
   }


   $scope.removeFromMenu = function(pub_drink){

     var modalInstance = $uibModal.open({
       animation: $scope.animationsEnabled,
       templateUrl: 'confirmModalContent.html',
       controller: 'ModalRemoveFromMenuPubCtrl',
       resolve: {
         selected_pub_drink: function() {
           return pub_drink;
         }
       }
     });

     modalInstance.result.then(function () {
       loadPubData();
     }, function () {
         loadPubData();
     });

   };

   $scope.toggleAnimation = function () {
     $scope.animationsEnabled = !$scope.animationsEnabled;
   };

});

angular.module('yapp').controller('ModalInstanceCtrl', function ($scope, $uibModalInstance, drinks, selected_pub_drink, PubDrink, selected_pub) {

  $scope.drinks = drinks;
  $scope.editing = false;
  $scope.pub_id = selected_pub.id;

  if (selected_pub_drink != null){
    $scope.selected_pub_drink = selected_pub_drink;
    $scope.selected_drink = selected_pub_drink.drink;
    $scope.selected_price = selected_pub_drink.price;
    $scope.editing = true;
  }

  $scope.cancel = function () {
    $uibModalInstance.dismiss('cancel');
  };

  $scope.createPubDrink = function(selected_drink, selected_price){
        $scope.$broadcast('show-errors-check-validity');

        if ($scope.pubDrinkForm.$valid) {

            if ($scope.editing == true){

                $scope.selected_pub_drink.price = selected_price;
                $scope.selected_pub_drink.$update().
                    then(function(data)
                        {
                            $uibModalInstance.close();
                        }, function (e) {

                        });

            }else{
                var pub_drink = {
                    drink_id: selected_drink_id,
                    price: selected_price,
                    pub_id: $scope.pub_id
                };

                PubDrink.save({pub_drink: pub_drink}, function(){
                    $uibModalInstance.close();

                },function(e){
                    console.log(e);
                    if (e.data.errors && e.data.errors.length > 0)
                      alert(e.data.errors[0]);
                });
            }


        }else {
            console.log('no valido...');
        }
   };

})

angular.module('yapp').controller('ModalRemoveFromMenuPubCtrl', function ($scope, $uibModalInstance, PubDrink, selected_pub_drink) {

  $scope.pub_drink = selected_pub_drink;

  $scope.modalOptions = {
      closeButtonText: 'Cancelar',
      actionButtonText: 'Eliminar de la Carta',
      headerText: 'Eliminar ' + $scope.pub_drink.drink_name,
      bodyText: '¿Está seguro que desea sacar de la carta este trago?'
  };

  $scope.cancel = function() {
    $uibModalInstance.dismiss('cancel');
  };

  $scope.secondButton = function(){

    PubDrink.delete({id: $scope.pub_drink.id}).$promise.then(function(data)
    {
        $uibModalInstance.close();
    }, function (e) {
        $uibModalInstance.dismiss('cancel');
    });

  }

});
