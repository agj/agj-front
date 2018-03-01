
define( function (require) {
	'use strict';

	var isArray = require('../is').array;

	function flatten(levels, arr) {
		if (isArray(levels)) {
			arr = levels;
			levels = -1;
		} else if (!arr) {
			return function (arr) {
				return flatten(levels, arr);
			};
		}
		return arr.reduce(process(levels), []);
	}

	function process(levels) {
		return function (arr, item) {
			return arr.concat((levels > 0 || levels < 0) && isArray(item) ? flatten(levels - 1, item) : [item]);
		};
	}

	return flatten;
	
});
