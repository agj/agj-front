
define( function (require) {
	'use strict';

	function valueToKey(obj, value) {
		for (var key in obj) {
			if (!obj.hasOwnProperty(key))
				continue;
			if (obj[key] === value) {
				return key;
			}
		}
		return void 0;
	}

	return valueToKey;

});
