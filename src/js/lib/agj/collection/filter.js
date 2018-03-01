
define( function (require) {
	'use strict';

	var overload = require('../function/overload');
	var autoCurry = require('../function/autoCurry');
	var flip = require('../function/flip');
	var is = require('../is');

	function filterObject(obj, fn) {
		var r = {};
		for (var key in obj) {
			if (!obj.hasOwnProperty(key)) continue;
			if (fn.call(null, obj[key], key, obj)) r[key] = obj[key];
		}
		return r;
	}

	function filterArray(arr, fn) {
		return arr.filter(fn);
	}

	var flipped = overload(
		[[is.fn, is.array, overload.REST], flip(2, filterArray)],
		[[is.fn, is.set, overload.REST], flip(2, filterObject)]
	);

	var filter = overload(
		[[is.fn, overload.REST], autoCurry(2, flipped)],
		[[is.array, overload.REST], autoCurry(filterArray)],
		autoCurry(filterObject)
	);

	return filter;
	
});
