
define( function (require) {
	'use strict';

	function overlaps(arr, array) {
		var len = arr.length;
		for (var i = 0; i < len; i++) {
			if (array.indexOf(arr[i]) >= 0)
				return true;
		}
		return false;
	}

	return overlaps;
	
});
