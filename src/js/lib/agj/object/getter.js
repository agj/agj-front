
define( function (require) {
	'use strict';

	var autoCurry = require('../function/autoCurry');

	function getter(obj, prop) {
		return function () {
			return obj[prop];
		};
	}

	return autoCurry(getter);
	
});
