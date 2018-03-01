
define( function (require) {
	'use strict';

	var findIndex = require('./findIndex');
	var overload = require('../function/overload');
	var is = require('../is');

	function doFind(arr, predicate, thisArg) {
		var index = findIndex(arr, predicate, thisArg);
		if (index !== -1) return arr[index];
		return void 0;
	}

	var find = overload(
		[[is.set, is.fn, overload.REST], doFind],
		[[is.fn, is.set, overload.REST], function (predicate, arr, thisArg) {
			return doFind(arr, predicate, thisArg);
		}],
		[[is.fn], function (predicate) {
			return function (arr, thisArg) {
				return doFind(arr, predicate, thisArg);
			};
		}],
		[[is.set], function (arr) {
			return function (predicate, thisArg) {
				return doFind(arr, predicate, thisArg);
			};
		}]
	);

	return find;
	
});
