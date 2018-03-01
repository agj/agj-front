
define( function (require) {
	'use strict';

	function parseRGB(color) {
		return {
			red:   (color & 0xff0000) >> 16,
			green: (color & 0x00ff00) >> 8,
			blue:  (color & 0x0000ff),
		};
	}

	return parseRGB;

});
