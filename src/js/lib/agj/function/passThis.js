
define( function (require) {
	'use strict';
	
	function passThis(fn) {
		return function () {
			return fn.call(this, this);
		};
	}

	return passThis;

});
