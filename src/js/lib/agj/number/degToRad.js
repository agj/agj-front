
define( function (require) {
	'use strict';

	var TAU = Math.PI * 2;

	function degToRad(num) {
		return num * TAU / 360;
	}

	return degToRad;

});