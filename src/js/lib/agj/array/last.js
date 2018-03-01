
define( function (require) {
	'use strict';

	var overload = require('../function/overload');
	var is = require('../is');
	var not = require('../function/not');

	function getLastSingle(arr) {
		return arr[arr.length - 1];
	}

	function getLastMultiple(arr, amount) {
		if (amount === 0) return [];
		return arr.slice(-amount);
	}

	var last = overload(
		[[not(is.number)], getLastSingle],
		[[is.set, is.number, overload.REST], getLastMultiple],
		[[is.number, is.set, overload.REST], function (amount, arr) {
			return getLastMultiple(arr, amount);
		}],
		[[is.number], function (amount) {
			return function (arr) {
				return getLastMultiple(arr, amount);
			};
		}]
	);

	return last;

});
