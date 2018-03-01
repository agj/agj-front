
define( function (require) {
	'use strict';

	var last = require('./last');

	function endsWith(str, end) {
		return last(str, end.length) === end;
	}

	return endsWith;

});
