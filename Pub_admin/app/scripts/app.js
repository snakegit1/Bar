angular
  .module('yapp', [
    '720kb.datepicker',
    'ui.router',
    'ngAnimate',
    'ng-token-auth',
    'ngResource',
    'angular.filter',
    'ui.bootstrap',
    'nya.bootstrap.select',
    'ui.bootstrap.showErrors',
    'naif.base64'])
  .constant('config', {
    //server_address: 'http://api.box-free.com',
    server_address:'http://localhost:3000',
    version: '0.5'
  })
  .run(['$rootScope', 'config', function($rootScope, config){
    $rootScope.version = config.version;
  }])
  .config(['$stateProvider', '$urlRouterProvider', '$authProvider', 'config', function($stateProvider, $urlRouterProvider, $authProvider, config) {

    $authProvider.configure({
        apiUrl: config.server_address+'/api',
        omniauthWindowType:  'newWindow',
        storage: 'localStorage'
    });


    $urlRouterProvider.when('/dashboard', '/dashboard/overview');
    $urlRouterProvider.otherwise('/login');

    $stateProvider
      .state('base', {
        abstract: true,
        url: '',
        templateUrl: 'views/base.html'
      })
        .state('login', {
          url: '/login',
          parent: 'base',
          templateUrl: 'views/login.html',
          controller: 'LoginCtrl'
        })
        .state('dashboard', {
          url: '/dashboard',
          parent: 'base',
          resolve: {
            auth: function($auth) {

              return $auth.validateUser();
            }
          },
          templateUrl: 'views/dashboard.html',
          controller: 'DashboardCtrl'
        })
          .state('overview', {
            url: '/overview?id',
            parent: 'dashboard',
            templateUrl: 'views/dashboard/overview.html',
            controller: 'OverviewCtrl'
          })
          .state('pubdrinks', {
            url: '/pubdrinks?id',
            parent: 'dashboard',
            templateUrl: 'views/dashboard/pubdrinks.html',
            controller: 'PubDrinkCtrl'
          })
          .state('pub', {
            url: '/pub',
            parent: 'dashboard',
            templateUrl: 'views/dashboard/pub.html',
            controller: 'PubCtrl'
          })
          .state('disabledPub', {
            url: '/disabledPub',
            parent: 'dashboard',
            templateUrl: 'views/dashboard/disabledPub.html',
            controller: 'OverviewCtrl'
          })
          .state('brand', {
            url: '/brand',
            parent: 'dashboard',
            templateUrl: 'views/dashboard/brand.html',
            controller: 'BrandCtrl'
          })
          .state('newdrink', {
            url: '/newdrink',
            parent: 'dashboard',
            templateUrl: 'views/dashboard/newdrink.html',
            controller: 'NewDrinkCtrl'
          })
          .state('reports', {
            url: '/reports?id',
            parent: 'dashboard',
            templateUrl: 'views/dashboard/reports.html',
            controller: 'cardSellsCtrl'
          })
          .state('gifts', {
            url: '/gifts?id',
            parent: 'dashboard',
            templateUrl: 'views/dashboard/gifts.html',
            controller: 'GiftCtrl'
          })
          .state('globalreport', {
            url: '/globalreport',
            parent: 'dashboard',
            templateUrl: 'views/dashboard/globalreport.html',
            controller: 'globalReportsCtrl'
          });

  }]);
