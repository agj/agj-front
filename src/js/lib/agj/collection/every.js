
define( function (require) {
	'use strict';

	var overload = require('../function/overload');
	var autoCurry = require('../function/autoCurry');
	var flip = require('../function/flip');
	var is = require('../is');

	function everyObject(obj, fn) {
		for (var key in obj) {
			if (!obj.hasOwnProperty(key)) continue;
			if (!fn.call(null, obj[key], key, obj)) return false;
		}
		return true;
	}

	function everyArray(arr, fn) {
		return arr.every(fn);
	}

	var flipped = overload(
		[[is.fn, is.array, overload.REST], flip(2, everyArray)],
		[[is.fn, is.set, overload.REST], flip(2, everyObject)]
	);

	var every = overload(
		[[is.fn, overload.REST], autoCurry(2, flipped)],
		[[is.array, overload.REST], autoCurry(everyArray)],
		autoCurry(everyObject)
	);

	return every;
	
});
