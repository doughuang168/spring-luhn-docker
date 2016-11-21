<!DOCTYPE html>
<html>

<head>
    <title>Angular JS Services</title>
    <script src = "https://ajax.googleapis.com/ajax/libs/angularjs/1.3.14/angular.min.js"></script>
</head>

<body>


<div style="width:100%" align="center" ng-app = "mainApp" ng-controller = "LuhnController">
    <h2>AngularJS Luhn Application</h2>

    <form name='luhn_form' novalidate>

    <p>Card number: <input type = "number" ng-model = "number" /></p>
    <br />
    <div>
		<button ng-click = "validate()">Validate</button>
        <label>: {{message}}</label>
	</div>
    <br />
    <br />
	<div>
        <button ng-click = "checkDigit()">CheckDigit</button>
        <label>: {{result}}</label>
	</div>
	</form>
</div>

<script>
    var mainApp = angular.module("mainApp", []);

    mainApp.factory('LuhnService', function($http,$window) {
        //since $http.get returns a promise,
        //and promise.then() also returns a promise
        //that resolves to whatever value is returned in it's
        //callback argument, we can return that.
        var str = $window.location.href;
        var re = /index\.ftl/gi;
        var indexurl = str.replace(re, '');
        console.log(indexurl);

        return {
            getLuhnVerification: function(cardNumber) {
		 return $http.get(indexurl+'api/validate/'+cardNumber, {headers: {"X-API-KEY": 'secretkey168'} }).then(function(result) {
                    return result.data;
                });
            },
            getLuhnCheckDigit: function(cardNumber) {
		return $http.get(indexurl+'api/checkdigit/'+cardNumber, {headers: {"X-API-KEY": 'secretkey168'} }).then(function(result) {
                    return result.data;
                });
            }
        }
    });


    mainApp.controller('LuhnController', function($scope, LuhnService) {
        $scope.validate = function() {
            //make the call to getLuhnVerification and handle the promise returned;
            LuhnService.getLuhnVerification($scope.number).then(function(data) {
                //this will execute when the
                //AJAX call completes.
                //console.log('validate card '+$scope.number);
                console.log(data);
                $scope.result = "";
                $scope.message = data.message;
            });

        };
        $scope.checkDigit = function() {
            //make the call to getLuhnVerification and handle the promise returned;
            LuhnService.getLuhnCheckDigit($scope.number).then(function(data) {
                //this will execute when the
                //AJAX call completes.
                //console.log('generate check digit for card '+$scope.number);
                //$scope.check = data;
                console.log(data);
                $scope.message ="";
				$scope.result = data.result;
            });

        };
    });

</script>

</body>
</html>
