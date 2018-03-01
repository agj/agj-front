/**
 * Similar to the "".concat() method, but with one difference: it will replace null and undefined values with
 * an empty string.
 */
define( function (require) {
	'use strict';

	var toArray = require('../utils/toArray');

	function concat(str) {
		return toArray(arguments).join('');
	}

	return concat;

});
