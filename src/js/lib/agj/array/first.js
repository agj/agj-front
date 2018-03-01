
define( function (require) {
	'use strict';

	var overload = require('../function/overload');
	var is = require('../is');
	var not = require('../function/not');

	function getFirstSingle(arr) {
		return arr[0];
	}

	function getFirstMultiple(arr, amount) {
		return arr.slice(0, amount);
	}

	var first = overload(
		[[not(is.number)], getFirstSingle],
		[[is.set, is.number, overload.REST], getFirstMultiple],
		[[is.number, is.set, overload.REST], function (amount, arr) {
			return getFirstMultiple(arr, amount);
		}],
		[[is.number], function (amount) {
			return function (arr) {
				return getFirstMultiple(arr, amount);
			};
		}]
	);

	return first;
	
});
