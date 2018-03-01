
define( function (require) {
	'use strict';

	var overload = require('../function/overload');
	var is = require('../is');
	var toArray = require('../utils/toArray');

	function productCallback(lists, callback) {
		iterate([], lists, callback);
	}
	function iterate(selected, remaining, callback) {
		var next = remaining.length > 1 ? remaining.slice(1) : null;
		return remaining[0].some( function (item) {
			var current = selected.concat([item]);
			if (next) return iterate(current, next, callback);
			return callback.apply(null, current);
		});
	}

	function productArray(lists) {
		var result = [];
		productCallback(lists, function () {
			result.push(toArray(arguments));
		});
		return result;
	}

	var cartesianProduct = overload(
		[[is.array, is.fn], productCallback],
		productArray
	);

	return cartesianProduct;

});
