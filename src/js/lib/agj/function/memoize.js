/**
 * This memoization function is naive in that it assumes a single argument,
 * which should be a string or number to serialize correctly.
 */
define( function (require) {
	'use strict';

	function memoize(fn) {
		var memo = {};
		return function memoized(v) {
			if (v in memo) return memo[v];
			return memo[v] = fn(v);
		};
	}

	return memoize;

});
