angular.module('yapp')
  .controller('NewDrinkCtrl', function(config, $scope, $http, $rootScope, $state, $stateParams, $auth, $resource, $location, User, Pub,Drink, $uibModal, DrinkCategory,config) {

    init();
    $scope.url = config.server_address;
    function init(){
      $scope.drink = {};
      loadPubData();
      loadDrinkCategoryData();
    };

    function loadPubData(){

      Pub.query().$promise.then(function (results) {
        $rootScope.pubs = results;
        $scope.allPermissions = true;

      }, function(error) {

      });
    };

    function loadDrinkCategoryData(){

      DrinkCategory.query({include_drinks: true}).$promise.then(function (results) {
        $rootScope.drink_categories = results;
        console.log(results);

      }, function(error) {

      });
    };


    $scope.createNewDrinkCategory = function(drink_category){

      var modalInstance = $uibModal.open({
        animation: $scope.animationsEnabled,
        templateUrl: 'newDrinkCategoryModalContent.html',
        controller: 'ModalNewDrinkCategoryCtrl',
        resolve: {
          drink_category: function () {
            return drink_category;
          }
        }
      });


      modalInstance.result.then(function () {
        loadDrinkCategoryData();
      }, function () {
        loadDrinkCategoryData();
      });

    };


    $scope.createNewDrink = function (drink) {

     var modalInstance = $uibModal.open({
       animation: $scope.animationsEnabled,
       templateUrl: 'newDrinkModalContent.html',
       controller: 'ModalNewDrinkCtrl',
       resolve: {
         drink_categories: function () {
           return $scope.drink_categories;
         },
         drink: function () {
           return drink;
         }
       }
     });

     modalInstance.result.then(function () {
       loadDrinkCategoryData();
     }, function () {
       loadDrinkCategoryData();
     });
   };


   $scope.destroyDrinkCategory = function(drink_category){

     var modalInstance = $uibModal.open({
       animation: $scope.animationsEnabled,
       templateUrl: 'confirmModalContent.html',
       controller: 'ModalDeleteCategoryCtrl',
       resolve: {
         selected_drink_category: function() {
           return drink_category;
         }
       }
     });

     modalInstance.result.then(function () {
       loadDrinkCategoryData();
     }, function () {
         loadDrinkCategoryData();
     });

   };


    $scope.disableDrink = function (drinkId) {
      var params = {
        id: drinkId,
      };

      $http.put(config.server_address + '/api/drinks/enable_drink', params, {
        headers: $auth.retrieveData('auth_headers')
      })
      .then(function(results){
        if (results.status === 200) {
          $rootScope.drink_categories = results.data;
        }
      })
      .finally(function(){

      });
    }

    $scope.disableDrinkCategory = function (categoryId) {
      var params = {
        id: categoryId,
      };

      $http.put(config.server_address + '/api/drink_categories/enable_category', params, {
        headers: $auth.retrieveData('auth_headers')
      })
      .then(function(results){
        if (results.status === 200) {
          $rootScope.drink_categories = results.data;
        }
      })
      .finally(function(){

      });
    }

   $scope.removeFromSystem = function(drink){

     var modalInstance = $uibModal.open({
       animation: $scope.animationsEnabled,
       templateUrl: 'confirmModalContent.html',
       controller: 'ModalDeleteDrinkCtrl',
       resolve: {
         selected_drink: function() {
           return drink;
         }
       }
     });

     modalInstance.result.then(function () {
       loadDrinkCategoryData();
     }, function () {
         loadDrinkCategoryData();
     });

   };



})

angular.module('yapp').controller('ModalNewDrinkCtrl', function ($scope, $uibModalInstance, Drink, DrinkCategory, drink_categories, drink) {

  $scope.drink_categories = drink_categories;
  $scope.drink = {};

  if (drink){
    $scope.drink = drink;
    $scope.editing = true;
    console.log($scope.drink);
  }
  else{
    $scope.editing = false;
  }

  $scope.editDrink = function(drink){
    var file = document.querySelector('input[type=file]').files[0]; //sames as here

    var edit_drink = {
        id: drink.id,
        name: drink.name
    };

    Drink.get({id: drink.id}, function(get_drink){
      get_drink.name = drink.name;

      if (file) {
        get_drink.image_file_name = file.name;
        get_drink.image_content_type = file.type;
        get_drink.image_file_size = file.size;
        get_drink.image_updated_at = Date(file.lastModified);
      }

      get_drink.$update().
        then(function(data)
        {
            $uibModalInstance.close();

        }, function (e) {
            console.log('update error');
        });

    }, function(e){
        alert('Error desconocido');
    });

  };

  $scope.createNewDrink = function(drink){
    var file = document.querySelector('input[type=file]').files[0]; //sames as here
    var new_drink = {};

    if (file) {
      new_drink = {
        name: drink.name,
        drink_category_id: drink.category.id,
        image_file_name: file.name,
        image_content_type: file.type,
        image_file_size: file.size,
        image_updated_at: Date(file.lastModified)
      };
    }

    else {
      new_drink = {
        name: drink.name,
        drink_category_id: drink.category.id
      };
    }

    Drink.save({drink: new_drink}, function(){
        $uibModalInstance.close();
    }, function(e){
        if (e.data.errors && e.data.errors.length > 0)
          alert(e.data.errors[0]);
    });
  }

  $scope.cancel = function () {
    $uibModalInstance.dismiss('cancel');
  };

})

angular.module('yapp').controller('ModalNewDrinkCategoryCtrl', function ($scope, DrinkCategory, $uibModalInstance, drink_category) {

  $scope.drink_category = {};

  if (drink_category){
    $scope.drink_category = drink_category;
    $scope.editing = true;
  }
  else{
    $scope.editing = false;

    DrinkCategory.query().$promise.then(function (results) {
      $scope.drink_categories = results;
      console.log(results);
    }, function(error) {

    });
  }


  $scope.newDrinkCategory = function(drink_category){

    var new_drink_category = {
        name: drink_category.name
    };

    DrinkCategory.save({drink_category: new_drink_category}, function(){

        $uibModalInstance.close();

    }, function(e){
        console.log(e);
        if (e.data.errors && e.data.errors.length > 0)
          alert(e.data.errors[0]);
    });
  };

  $scope.editDrinkCategory = function(drink_category){

    drink_category.$update().
      then(function(data)
      {
          console.log('update ok');
          $uibModalInstance.close();

      }, function (e) {
          console.log('update error');

      });
  };



  $scope.cancel = function () {
    $uibModalInstance.dismiss('cancel');
  };

})


angular.module('yapp').controller('ModalDeleteCategoryCtrl', function ($scope, $uibModalInstance, Pub, selected_drink_category) {

  $scope.drink_category = selected_drink_category;

  $scope.modalOptions = {
      closeButtonText: 'Cancelar',
      actionButtonText: 'Eliminar Categoría del Sistema',
      headerText: 'Eliminar ' + $scope.drink_category.name,
      bodyText: '¿Está seguro que desea eliminar esta categoría (se eliminarán todos los tragos de esta categoría en todos los Pubs)?'
  };

  $scope.cancel = function () {
    $uibModalInstance.dismiss('cancel');
  };

  $scope.secondButton = function(){

    $scope.drink_category.$delete().
      then(function(data)
      {
        $uibModalInstance.close();
      }, function (e) {
        $uibModalInstance.close();
      });


  }

})

angular.module('yapp').controller('ModalDeleteDrinkCtrl', function ($scope, $uibModalInstance, Drink, selected_drink) {

  $scope.drink = selected_drink;

  $scope.modalOptions = {
      closeButtonText: 'Cancelar',
      actionButtonText: 'Eliminar del Sistema',
      headerText: 'Eliminar ' + $scope.drink.name,
      bodyText: '¿Está seguro que desea eliminar este trago (se eliminara también de todos los pubs)?'
  };

  $scope.cancel = function () {
    $uibModalInstance.dismiss('cancel');
  };

  $scope.secondButton = function(){

    Drink.delete({id: $scope.drink.id}).$promise.then(function(data)
    {
      $uibModalInstance.close();
    }, function (e) {
      $uibModalInstance.close();
    });


  }

});
