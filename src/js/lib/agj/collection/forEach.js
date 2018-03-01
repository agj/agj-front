
define( function (require) {
	'use strict';

	var overload = require('../function/overload');
	var autoCurry = require('../function/autoCurry');
	var flip = require('../function/flip');
	var is = require('../is');

	function forEachObject(obj, fn) {
		for (var key in obj) {
			if (!obj.hasOwnProperty(key)) continue;
			fn.call(null, obj[key], key, obj);
		}
		return obj;
	}

	function forEachArray(arr, fn) {
		arr.forEach(fn);
		return arr;
	}

	var flipped = overload(
		[[is.fn, is.array, overload.REST], flip(2, forEachArray)],
		[[is.fn, is.set, overload.REST], flip(2, forEachObject)]
	);

	var forEach = overload(
		[[is.fn, overload.REST], autoCurry(2, flipped)],
		[[is.array, overload.REST], autoCurry(forEachArray)],
		autoCurry(forEachObject)
	);

	return forEach;
	
});
