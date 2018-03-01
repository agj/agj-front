
define( function (require) {
	'use strict';

	var overload = require('../function/overload');
	var is = require('../is');
	
	function doFindIndex(arr, predicate, thisArg) {
		var i = -1;
		var len = arr.length;
		while (i++, i < len) {
			if (predicate.call(thisArg, arr[i], i, arr)) return i;
		}
		return -1;
	}

	var findIndex = overload(
		[[is.set, is.fn, overload.REST], doFindIndex],
		[[is.fn, is.set, overload.REST], function (predicate, arr, thisArg) {
			return doFindIndex(arr, predicate, thisArg);
		}],
		[[is.fn], function (predicate) {
			return function (arr, thisArg) {
				return doFindIndex(arr, predicate, thisArg);
			};
		}],
		[[is.set], function (arr) {
			return function (predicate, thisArg) {
				return doFindIndex(arr, predicate, thisArg);
			};
		}]
	);

	return findIndex;
	
});
