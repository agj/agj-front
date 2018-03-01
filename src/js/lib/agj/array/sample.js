
define( function (require) {
	'use strict';

	var overload = require('../function/overload');
	var clone = require('../array/clone');
	var randomInt = require('../random/integer');
	var is = require('../is');

	function sampleSingle(arr) {
		var len = arr.length;
		if (len <= 0) return agj.undefined;
		return arr[randomInt(len)];
	}

	function sampleMultiple(arr, amount) {
		var result = [];
		var remaining = clone(arr);
		amount = Math.min(amount, arr.length) + 1;
		while (--amount > 0) {
			var index = randomInt(amount);
			result.push(remaining[index]);
			remaining.splice(index, 1);
		}
		return result;
	}

	var sample = overload(
		[[is.array], sampleSingle],
		[[is.array, is.number], sampleMultiple],
		[[is.number, is.array], function (amount, arr) {
			return sampleMultiple(arr, amount);
		}],
		[[is.number], function (amount) {
			return function (arr) {
				return sampleMultiple(arr, amount);
			};
		}]
	);

	return sample;
	
});
