
define( function (require) {
	'use strict';

	var first = require('./first');

	function startsWith(str, start) {
		return first(str, start.length) === start;
	}

	return startsWith;

});
