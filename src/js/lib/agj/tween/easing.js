
define( function (require) {
	'use strict';

	var TAU = Math.PI * 2;

	return {
		linear: function (p) {
			return p;
		},
		easeInQuad: function (p) {
			return p * p;
		},
		easeOutSine: function (p) {
			return Math.sin(p * (TAU / 4));
		}
	};

});
