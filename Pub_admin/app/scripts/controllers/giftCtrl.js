/**
 * @ngdoc function
 * @name yapp.controller:GiftCtrl
 * @description
 * # GiftCtrl
 * Controller of yapp
 */

angular.module('yapp')
  .controller('GiftCtrl', function ($scope, $stateParams, Gift, Drink, User,Pub, PubDrink, $uibModal) 
    {
      init();

      function init() {
        loadUserData();
        loadPubData();
      };

      function loadPubData(){

        Pub.query().$promise.then(function (results) {
          $scope.pubs = results;
  
          if ($stateParams.id != null){
            $scope.pub = results.find(r => r.id === Number($stateParams.id))
            $scope.drinks = $scope.pub.pub_drinks
          }
          else {
            $scope.pub = results[0];
            $scope.drinks = $scope.pub.pub_drinks
          }
  
          $scope.allPermissions = true;
  
        }, function(error) {
          $scope.pub = null;
        });
      };

      function loadUserData() {
        User.query().$promise.then(function (results) {
          $scope.users = results;
          $scope.allPermissions = true;
        }, function(error) {
          $scope.user = null;
        });
      };

      $scope.openModal = function (user) {
        Gift.query({user_id: user.id, pub_id: $scope.pub.id}).$promise.then(function (gifts) {
          startModal(gifts, user, $scope.pub);
        }, function(errResponse) {
            console.log('Error!');
        });
      };

      function startModal(gifts, user, pub){
        var modalInstance = $uibModal.open({
          animation: $scope.animationsEnabled,
          templateUrl: 'giftModal.html',
          controller: 'GiftModalCtrl',
          resolve: {
            gifts: function () {
              return gifts;
            },
            user: function () {
              return user;
            },
            drinks: function() {
              return $scope.drinks;
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
});


angular.module('yapp').controller('GiftModalCtrl', function ($scope, $uibModalInstance, gifts, user, drinks, selected_pub, Gift) {
  $scope.drinks = drinks;
  $scope.user = user;
  $scope.gifts = gifts;

  $scope.cancel = function () {
    $uibModalInstance.dismiss('cancel');
  };

  $scope.createGift = function(drink_id) {
    $scope.$broadcast('show-errors-check-validity');

    var gift = {
      user_id: $scope.user.id,
      drink_id: drink_id,
      pub_id: selected_pub.id
    };
    Gift.save({gift: gift}, function(gift) {
      $scope.gifts.push(gift);
    }, function(e) {
      console.log(e);
      if (e.data.errors && e.data.errors.length > 0)
        alert(e.data.errors[0]);
    });
  }

  $scope.deleteGift = function(gift, index) {
    Gift.delete({id: gift.id}, function() {
      $scope.gifts.splice(index, 1);
    });
  }
});
