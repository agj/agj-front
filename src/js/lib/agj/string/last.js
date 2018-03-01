
define( function (require) {
	'use strict';

	function last(str, amount) {
		if (isNaN(amount)) amount = 1;
		return str.slice(-amount);
	}

	return last;

});
