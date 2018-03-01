
define( function (require) {
	'use strict';

	function get2D(arr, width, x, y) {
		return arr[x + y * width];
	}

	return get2D;
	
});
