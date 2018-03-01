
define( function (require) {
	'use strict';

	var overload = require('../function/overload');
	var autoCurry = require('../function/autoCurry');
	var flip = require('../function/flip');
	var is = require('../is');

	function someObject(obj, fn) {
		for (var key in obj) {
			if (!obj.hasOwnProperty(key)) continue;
			if (fn.call(null, obj[key], key, obj)) return true;
		}
		return false;
	}

	function someArray(arr, fn) {
		return arr.some(fn);
	}

	var flipped = overload(
		[[is.fn, is.array, overload.REST], flip(2, someArray)],
		[[is.fn, is.set, overload.REST], flip(2, someObject)]
	);

	var some = overload(
		[[is.fn, overload.REST], autoCurry(2, flipped)],
		[[is.array, overload.REST], autoCurry(someArray)],
		autoCurry(someObject)
	);

	return some;
	
});
