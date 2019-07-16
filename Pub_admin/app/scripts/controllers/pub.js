/**
 * @ngdoc function
 * @name yapp.controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of yapp
 */
angular.module('yapp')
  .controller('PubCtrl', function($scope, $rootScope, $state, $stateParams, $auth, $resource, $location, User, Pub, $uibModal) {

    init();

    function init(){

      $scope.pub = {};
      getUsers();
      loadPubData();

    };

    function loadPubData(){

      Pub.query().$promise.then(function (results) {
        $rootScope.pubs = results;
        $scope.allPermissions = true;

      }, function(error) {

      });
    };

    function getUsers(){
      User.query({only_admins: true}).$promise.then(function (result) {
        console.log(result);
        $scope.users = result;

      });
    }

    $scope.createPub = function(){
      $scope.$broadcast('show-errors-check-validity');

     if (!$scope.pubForm.$valid) {
       console.log('form error');
       return;
     }

      if ($scope.selected_user == null){
        alert('Debe seleccionar un administrador!');
        return;
      }else{
        $scope.pub.user_id = $scope.selected_user.id;
        Pub.save({pub: $scope.pub}, function(e){
            console.log('saved');
            loadPubDataAndRedirect(e.id);
            console.log(e);

        }, function(e){
            console.log(e);
        });
      }
    }

    function loadPubDataAndRedirect(pub_id){
    	Pub.query().$promise.then(function (result) {
    		console.log(result);
        $rootScope.pubs = result;
        $state.go('overview', { id: pub_id });
    	});
    };

    $scope.createAdmin = function(){

    }


    $scope.openModalNewAdmin = function () {

     var modalInstance = $uibModal.open({
       animation: $scope.animationsEnabled,
       templateUrl: 'newAdminModalContent.html',
       controller: 'ModalNewAdminInstanceCtrl',
       resolve: {
       }
     });

     modalInstance.result.then(function () {
        getUsers();
     }, function () {

     });
   };



})

angular.module('yapp').controller('ModalNewAdminInstanceCtrl', function ($scope, $uibModalInstance, User) {

  $scope.new_admin = {};
  $scope.send_email = true;

  $scope.cancel = function () {
    $uibModalInstance.dismiss('cancel');
  };

  $scope.createAdmin = function(new_admin, send_email){

    console.log(new_admin);
    User.save({user: new_admin, send_email: send_email}, function(){

        $uibModalInstance.close();
    }, function(e){
        console.log(e);
        if (e.data.email != null && e.data.email.length > 0)
          alert('E-Mail ' + e.data.email[0]);
        else if (e.data.password != null && e.data.password.length > 0)
          alert('Password ' + e.data.password[0]);
    });

   };

});
