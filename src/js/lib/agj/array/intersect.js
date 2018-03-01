
define( function (require) {
	'use strict';

	function intersect(arr, array) {
		return arr.filter( function (item) {
			return array.indexOf(item) !== -1;
		});
	}

	return intersect;
	
});
