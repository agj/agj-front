
define( function (require) {
	'use strict';

	var overload = require('../function/overload');
	var autoCurry = require('../function/autoCurry');
	var flip = require('../function/flip');
	var is = require('../is');

	function mapObject(obj, fn) {
		var r = {};
		for (var key in obj) {
			if (!obj.hasOwnProperty(key)) continue;
			r[key] = fn.call(null, obj[key], key, obj);
		}
		return r;
	}

	function mapArray(arr, fn) {
		return arr.map(fn);
	}

	var flipped = overload(
		[[is.fn, is.array, overload.REST], flip(2, mapArray)],
		[[is.fn, is.set, overload.REST], flip(2, mapObject)]
	);

	var map = overload(
		[[is.fn, overload.REST], autoCurry(2, flipped)],
		[[is.array, overload.REST], autoCurry(mapArray)],
		autoCurry(mapObject)
	);

	return map;
	
});
