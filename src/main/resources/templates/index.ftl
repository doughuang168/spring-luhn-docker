<!DOCTYPE html>
<html>

<head>
    <title>Angular Luhn App</title>
    <script src = "https://ajax.googleapis.com/ajax/libs/angularjs/1.3.14/angular.min.js"></script>
    <style>
        td
        {
            border: 1px solid green;
            overflow: hidden;
        }
    </style>

</head>

<body>


<div style="width:100%" align="center" ng-app = "mainApp" ng-controller = "LuhnController">
    <h2>AngularJS Application</h2>

    <form name='luhn_form' novalidate>
    <div>
        <fieldset style="width:50%" align="center">
            <legend>Luhn Number Validation and CheckDigit Generation</legend>

            <p>Card number: <input type = "number" ng-model = "number" /></p>

            <table style="width:50%" align="center">
                <tr>
                    <td style="width: 20%;"><button style="font-size:18px;" ng-click = "validate()">Validate</button>
                    </td>
                    <td style="width: 80%;"><label>{{message}}</label>
                    </td>
                </tr>

                <tr>
                    <td style="width: 20%;"><button style="font-size:14px;" ng-click = "checkDigit()">CheckDigit</button>
                    </td>
                    <td style="width: 80%;"><label>{{result}}</label>
                    </td>
                </tr>
                <br />
            </table>

            <br/>
            <p>Number Of Valid LuhnNumbers In Range</p>

            <table style="width:50%" align="center">
                <tr>
                    <td style="width: 20%;"><label>StartRange</label>
                    </td>
                    <td style="width: 80%;"><input type = "number" ng-model = "start" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 20%;"><label>End Range</label>
                    </td>
                    <td style="width: 80%;"><input type = "number" ng-model = "end" />
                    </td>
                </tr>
                <tr>
                    <td style="width: 20%;"><button style="font-size:14px;" ng-click = "getrange()">RangeCount</button>
                    </td>
                    <td style="width: 80%;"><label>{{rangecount}}</label>
                    </td>
                </tr>
            </table>



        </fieldset>
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
		 return $http.get(indexurl+'api/validate/'+cardNumber,
                        {headers: {"X-API-KEY": 'secretkey168'} }).then(function(result) {
                    return result.data;
                });
            },
            getLuhnCheckDigit: function(cardNumber) {
		return $http.get(indexurl+'api/checkdigit/'+cardNumber,
                        {headers: {"X-API-KEY": 'secretkey168'} }).then(function(result) {
                    return result.data;
                });
            },
            //http://localhost:8080/api/validcardnumber?startRange=7992739871&endRange=301
            getLuhnRangeCount: function(startRange, endRange) {
        return $http.get(indexurl+'api/validcardnumber?startRange='+startRange+'&endRange='+endRange,
                        {headers: {"X-API-KEY": 'secretkey168'} }).then(function(result) {
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
        $scope.getrange = function() {
            //make the call to getLuhnVerification and handle the promise returned;
            LuhnService.getLuhnRangeCount($scope.start, $scope.end).then(function(data) {
                //this will execute when the
                //AJAX call completes.
                //console.log('generate check digit for card '+$scope.number);
                //$scope.check = data;
                console.log(data);
                $scope.message ="";
                $scope.rangecount = data.result;
            });

        };
    });

</script>

</body>
</html>
