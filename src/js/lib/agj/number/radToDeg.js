
define( function (require) {
	'use strict';

	var TAU = Math.PI * 2;

	function radToDeg(num) {
		return num * 360 / TAU;
	}

	return radToDeg;

});
