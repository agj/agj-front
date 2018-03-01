
define( function (require) {
	'use strict';

	function values(obj) {
		var result = [];
		for (var key in obj) {
			if (obj.hasOwnProperty(key)) result.push(obj[key]);
		}
		return result;
	}

	return values;

});
