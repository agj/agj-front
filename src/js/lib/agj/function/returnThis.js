
define( function (require) {
	'use strict';
	
	function returnThis(fn) {
		return function () {
			fn.apply(this, arguments);
			return this;
		};
	}

	return returnThis;

});
