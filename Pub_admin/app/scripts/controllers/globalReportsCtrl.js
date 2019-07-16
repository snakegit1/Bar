/**
 * @ngdoc function
 * @name yapp.controller:globalReportsCtrl
 * @description
 * # globalReportsCtrl
 * Controller of yapp
 */
angular.module('yapp')
.controller('globalReportsCtrl', function($scope, $rootScope, $state, $stateParams, $auth, $resource, $location, User, Pub, $uibModal, cardSellsSrv) {

  init();

  function init(){
    loadCardSells();
    loadPubData();
    $scope.orders = {};
    $scope.pub = {};
    $scope.pubs = {};
    $scope.date_start = null;
    $scope.date_end = null;
    $scope.drinks = [];
  };

  $scope.refreshOrders = function(){
    loadCardSells();
  };
  

  $scope.downloadData = function() {
    cardSellsSrv.query({pub_id: $stateParams.id, date_start: $scope.date_start, date_end: $scope.date_end}).$promise.then(function (results) {

          var headers = [];
          var body = [];
          var tmp_date = new Date();
          var filename = "CSV-REPORTE-" + tmp_date.getTime() + ".csv";
          var csvString = '\"';
          var colDelim = '","';
          var rowDelim = '"\r\n"';

          // We generate headers
          // :name, :lastname, :born_date, :genre, :braintree_customer_id
          headers.push("ID TRANSACCION");
          headers.push("NOMBRE");
          headers.push("APELLIDO");
          headers.push("FECHA DE NACIMIENTO");
          headers.push("SEXO");
          headers.push("ID BRAINTREE");
          headers.push("CORREO ELECTRONICO");
          headers.push("PUB");
          headers.push("TRAGO");
          headers.push("FUE CANJEADO");
          headers.push("FECHA DE COMPRA");
          headers.push("FECHA DE CANJE");
          headers.push("PRECIO");
          headers.push("CANTIDAD");
          headers.push("TOTAL ORDEN");
          headers.push("TOTAL TRAGOS");
          headers.push("BRAINTREE TOKEN");

          csvString += headers.join(colDelim) + rowDelim;

          for(var i in results) {

            for(var y in results[i].drinks) {
              // Fields
              var body = [];
              body.push( results[i].id,  results[i].user.name, results[i].user.lastname, results[i].user.born_date, results[i].user.gener, results[i].user.braintree_customer_id, results[i].user.email, results[i].pub.name, results[i].drinks[y].name, results[i].status_traslated, results[i].created_at_formated, results[i].updated_at_formated, results[i].drinks[y].price, results[i].drinks[y].quantity, results[i].price, results[i].drinks[y].price * results[i].drinks[y].quantity, results[i].token);
              csvString += body.join(colDelim) + rowDelim;
            }              
          }            

          if (window.navigator.msSaveOrOpenBlob) {
            // IE 10+
            var blob = new Blob([decodeURIComponent(encodeURI(csvString))], {
                type: 'text/csv;charset=' + document.characterSet
            });
            window.navigator.msSaveBlob(blob, filename);
          } else {
            var a         = document.createElement('a');
            a.href        = 'data:application/csv;charset=utf-8,' + encodeURIComponent(csvString);
            a.target      = '_blank';
            a.download    = filename;
            
            document.body.appendChild(a);
            a.click();              
          }

      });
  }

  $scope.showOrder = function(order_id){

    if($("#display-order-" + order_id).length == 0) {
      $("#show-order-" + order_id).css("background-color", "#fcf8e3");
      $("#show-details-" + order_id).text("Cargando ...");
      cardSellsSrv.query({id: order_id}).$promise.then(function (results) {
        $scope.drinks = results[0].drinks;
        $scope.payment = results[0].payment;
      }).then(function() {
      
          var buffer = "<tr id='display-order-" + order_id + "'>";
          buffer += '<td colspan="9" style="background-color:#666">';
          buffer += '<p style="text-align:center;color:#f5f5f5;font-size:16px"><img src="' + $scope.payment.image_url + '" /> Pagado con tarjeta  ' + $scope.payment.card_type + " con los últimos 4 digitos <strong>" +  $scope.payment.last_4 + ".</strong></p>";
            buffer += '<table class="table table-stripped" style="background-color:#666">';
                buffer += '<thead>';
                    buffer += '<th style="color:white">Trago</th>';
                    buffer += '<th style="color:white">Categoría</th>';
                    buffer += '<th style="color:white">Precio</th>';
                    buffer += '<th style="color:white">Cantidad</th>';
                    buffer += '<th style="color:white">Total</th>';
                buffer += '</thead>';
                buffer += '<tbody>';
                  var totalPayed = 0;
                  for(var i in $scope.drinks) {
                    var drink = $scope.drinks[i];
                    buffer += '<tr>';
                      buffer += '<td style="color:white">' + drink.name + '</td>';
                      buffer += '<td style="color:white">' + drink.category + '</td>';
                      buffer += '<td style="color:white">$' + drink.price + '</td>';
                      buffer += '<td style="color:white">' + drink.quantity + '</td>';
                      buffer += '<td style="color:white">$' + (drink.price * drink.quantity) + '</td>';
                    buffer += '</tr>';
                    totalPayed += (drink.price * drink.quantity);
                  }

                buffer += '<tr>';
                    buffer += '<td style="color:white;font-weight:bold;text-align:right;" colspan="4">Total Pagado</td>';
                    buffer += '<td style="color:white">$' + totalPayed + '</td>';
                  buffer += '</tr>';
                buffer += '</tbody>';
            buffer += '</table></td></tr>';
            
            $("#show-order-" + order_id).after(buffer);
            $("#show-details-" + order_id).text("Cerrar Detalle");              
      });

    } else {
      $("#show-order-" + order_id).css("background-color", "transparent");
      $("#display-order-" + order_id).remove();
      $("#show-details-" + order_id).text("Ver Detalle");
    }

  };

  $scope.cancel = function () {
    $uibModalInstance.dismiss('cancel');
  };

  function loadCardSells(){
    cardSellsSrv.query({limit: 200, pub_id: $stateParams.id, date_start: $scope.date_start, date_end: $scope.date_end}).$promise.then(function (results) {
      $scope.orders = results;
    }, function(error) {
    });
  };

  function loadPubData(){

    Pub.query().$promise.then(function (results) {
      $scope.pubs = results;

      if ($stateParams.id != null){

        for(var i=0; i < results.length; i++){

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

});