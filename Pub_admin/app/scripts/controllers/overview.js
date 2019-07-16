/**
 * @ngdoc function
 * @name yapp.controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of yapp
 */
angular.module('yapp')
  .controller('OverviewCtrl', ['config', '$scope', '$rootScope', '$state', '$stateParams', '$resource', '$auth', '$location', 'Pub', 'Drink', 'PubDrink', '$uibModal', '$http',
  function(config, $scope, $rootScope, $state, $stateParams, $resource, $auth, $location, Pub, Drink, PubDrink, $uibModal, $http) {

    $scope.bank_names = ["Banco Estado","Banco De Chile", "Banco Internacional", "Scotiabank Chile", "Banco De Credito E Inversiones ", "Corpbanca ", "Banco Bice", "Hsbc Bank (Chile) ", "Banco Santander Chile ", "Banco Itau Chile ", "Banco Security ", "Banco Falabella ", "Deutsche Bank (Chile) ", "Banco Ripley ", "Rabobank Chile ", "Banco Consorcio (Ex Banco Monex) ", "Banco Penta ", "Banco Paris ", "Banco Bilbao Vizcaya Argentaria, Chile (Bbva)", "Banco Btg Pactual Chile", "Otra Entidad"];
    $scope.bank_account_types = ["Cuenta Corriente", "Cuenta Vista"];
    $scope.pub_indexes = [];

    init();

    function init(){
      loadPubData();
    };


    function loadPubData(){

      Pub.query().$promise.then(function (results) {
        const activePubs = results.filter(result => result.name && result.enable)
        const disabledPubs = results.filter(result => result.name && !result.enable)
        $rootScope.pubs = activePubs;
        $rootScope.disabledPubs = disabledPubs;

        if ($stateParams.id != null){

          for(var i=0; i < results.length; i++){

            $scope.pub_indexes.push(i);

            if (results[i].id == $stateParams.id){
              $scope.pub = results[i];
            }

          }

        }
        else{

          $scope.pub = results[0];
        }

        $scope.allPermissions = true;

      }, function(error) {
        $scope.pub = null;
      });
    };


    $scope.disablePub = function (id) {
      var params = {
          id: id,
      };

      $http.put(config.server_address + '/api/pubs/enable_pub', params, {
        headers: $auth.retrieveData('auth_headers')
      })
      .then(function(results){
        if (results.status === 200) {
          loadPubData();
        }
      })
      .finally(function(){

      });
    }

    $scope.deletePub = function(){

      var modalInstance = $uibModal.open({
        animation: $scope.animationsEnabled,
        templateUrl: 'confirmModalContent.html',
        controller: 'ModalDeletePubCtrl',
        resolve: {
          selected_pub: function() {
            return $scope.pub;
          }
        }
      });

      modalInstance.result.then(function () {
          loadPubData();
          $state.go('dashboard');
      }, function () {
          loadPubData();
      });

    };



    $scope.updateBank = function(bankForm){
      $scope.$broadcast('show-errors-check-validity');

      if (!bankForm.$valid) {
        console.log('form error');

        return;
      }else{
        $scope.pub.$update().
          then(function(data)
          {
              console.log('update ok');

          }, function (e) {
              console.log('update error');

          });
      }

    };

    $scope.formCompleteInValid = function(bankForm){

      try {
        return ( ($scope.pub.bank_name == null) || ($scope.pub.bank_name == "Selecciona un Banco") ||
          ($scope.pub.bank_account_type == null) || ($scope.pub.bank_account_type == "Tipo de Cuenta") ||
          !bankForm.$valid);
      } catch (e) {
        return true;
      }

    };

    $scope.missingBankInfo = function(){
      try {
        return (($scope.pub.bank_account_email.length == 0) ||
            ($scope.pub.bank_account_rut.length == 0) ||
            ($scope.pub.bank_account_number.length) == 0 ||
            ($scope.pub.bank_account_type.length) == 0 ||
            ($scope.pub.bank_name.length == 0));
      } catch (e) {
        return false;
      } finally {

      }
    };

    $scope.onAfterValidateFunc = function(event, fileObjects, fileList) {

      var params = {
          pub_id: $scope.pub.id,
          pub_logo_base64: JSON.stringify(fileObjects[0].base64),
          pub_logo_filename: fileObjects[0].filename,
          pub_logo_filetype: fileObjects[0].filetype
      };

      $http.post(config.server_address + '/api/pubs/upload_logo', params, {
        headers: $auth.retrieveData('auth_headers')
      })
      .success(function(data, status){

        $scope.pub = data;
      })
      .finally(function(){

      });


    };

}])

angular.module('yapp').controller('ModalDeletePubCtrl', function ($scope, $uibModalInstance, Pub, selected_pub) {

  $scope.pub = selected_pub;

  $scope.modalOptions = {
      closeButtonText: 'Cancelar',
      actionButtonText: 'Eliminar',
      headerText: 'Eliminar ' + $scope.pub.name,
      bodyText: '¿Está seguro que desea eliminar este Pub y toda su información?'
  };

  $scope.cancel = function () {
    $uibModalInstance.dismiss('cancel');
  };

  $scope.secondButton = function(){

    Pub.delete({id: $scope.pub.id}).$promise.then(function(data)
        {
          console.log(data);
          $uibModalInstance.close();
        }, function (e) {
          console.log('delete error');
          $uibModalInstance.dismiss('cancel');
        });
  }

})
