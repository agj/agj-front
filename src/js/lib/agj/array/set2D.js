
define( function (require) {
	'use strict';

	function set2D(arr, width, x, y, value) {
		arr[x + y * width] = value;
		return arr;
	}

	return set2D;
	
});
