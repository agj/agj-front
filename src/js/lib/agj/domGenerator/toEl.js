/**
 * Returns a function that will generate elements for the specified tag.
 * It is memoized for improved performance.
 */
define( function (require) {
	'use strict';

	var is = require('../is');
	var anyEl = require('./anyEl');
	var toArray = require('../utils/toArray');
	var memoize = require('../function/memoize');

	var toEl = memoize( function toEl(tag) {
		return function () {
			var args = toArray(arguments);
			var first = args[0];
			if (is.string(first) && (first[0] === '#' || first[0] === '.')) {
				args[0] = tag + args[0];
			} else {
				args = [tag].concat(args);
			}
			return anyEl.apply(null, args);
		};
	});

	return toEl;

});
