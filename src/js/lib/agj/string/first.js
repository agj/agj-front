
define( function (require) {
	'use strict';

	function first(str, amount) {
		if (isNaN(amount)) amount = 1;
		return str.slice(0, amount);
	}

	return first;

});
