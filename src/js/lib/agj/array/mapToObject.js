
define( function (require) {
	'use strict';

	function mapToObject(arr, fn, thisArg) {
		var r = {};
		arr.forEach( function (key, i) {
			r[key] = fn.call(thisArg, key, i, arr);
		});
		return r;
	}

	return mapToObject;
	
});
