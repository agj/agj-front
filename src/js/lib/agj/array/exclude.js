
define( function (require) {
	'use strict';

	function exclude(arr, array) {
		return arr.filter(function (item) {
			return array.indexOf(item) === -1;
		});
	}

	return exclude;
	
});
