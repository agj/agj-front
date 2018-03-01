
define( function (require) {
	'use strict';

	var isString = require('../is').string;

	function padRight(str, length, padding) {
		if (!isString(padding) || !padding) padding = ' ';
		var remaining = length - str.length;
		padding = new Array(Math.max(0, Math.ceil(remaining / padding.length) + 1))
			.join(padding)
			.slice(0, Math.max(0, remaining));
		return str + padding;
	}

	return padRight;

});
