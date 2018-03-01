
define( function (require) {
	'use strict';

	var overload = require('../function/overload');
	var autoCurry = require('../function/autoCurry');
	var promoteArg = require('../function/promoteArg');
	var is = require('../is');
	var values = require('../object/values');
	var first = require('../array/first');
	var last = require('../array/last');
	var tail = last(-1);

	// var reduce = overload(
	// 	[[is.fn], function (fn) {
	// 		return function (array, initial) {
	// 			return doReduce(array, fn, initial);
	// 		};
	// 	}],
	// 	[[is.set, is.fn, overload.REST], doReduce],
	// 	[[is.fn, is.set, overload.REST], function (fn, array, initial) {
	// 		return doReduce(array, fn, initial);
	// 	}],
	// 	[[is.set], function (array) {
	// 		return function (fn, initial) {
	// 			return doReduce(array, fn, initial);
	// 		};
	// 	}]
	// );

	function reduceObject(obj, fn, initial) {
		return reduceArray(values(obj), fn, initial);
	}

	function reduceArray(array, fn, initial) {
		if (initial === undefined) {
			initial = first(array);
			array = tail(array);
		}

		var result = initial;
		var i = -1, len = array.length;
		while (++i < len) {
			result = fn(result, array[i]);
		}
		return result;
	}

	var flipped = overload(
		[[is.fn, is.array, overload.REST], promoteArg(1, reduceArray)],
		[[is.fn, is.set, overload.REST], promoteArg(1, reduceObject)]
	);

	var reduce = overload(
		[[is.fn, overload.REST], autoCurry(2, flipped)],
		[[is.array, overload.REST], autoCurry(2, reduceArray)],
		autoCurry(2, reduceObject)
	);

	return reduce;
	
});
