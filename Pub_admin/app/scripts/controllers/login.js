/**
 * @ngdoc function
 * @name yapp.controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of yapp
 */
angular.module('yapp')
  .controller('LoginCtrl', function($rootScope, $scope, $location, $auth, $state, $resource, config) {

  	$scope.$on('auth:login-success', function (ev, user) {
		console.log('auth:login-success');
		$location.path('/dashboard');
	});

	$scope.$on('auth:validation-success', function (ev, user) {
		console.log('auth:login-success');
		console.log(user);
		$location.path('/dashboard');
	});

	$scope.$on('auth:validation-error', function (ev, reason) {
		console.log('auth:login-error');
		setErrorMsg(reason);
	});

	$scope.$on('auth:login-error', function (ev, reason) {
		console.log('auth:login-error');
		setErrorMsg(reason);
	});

	init();

	function init(){

		//console.log($scope.user);
		//if ($scope.user && $user.)
		//$location.path('/dashboard');
    $rootScope.pubs = [];
	};

	function setErrorMsg(reason){
		if (reason != null && reason.errors != null && reason.errors.length > 0){
		    $scope.login_message = reason.errors[0];
		}else {
		    $scope.login_message = "No ha sido posible conectar con el servidor";
		}
	};


  $scope.submitLoginForm = function(loginForm){
    console.log(loginForm);

    $auth.submitLogin(loginForm)
        .then(function(resp) {
         console.log(resp);
        })
        .catch(function(resp) {
          // handle error response
          console.log(resp);
        });
  };





  });
