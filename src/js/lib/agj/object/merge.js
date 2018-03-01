
define( function (require) {
	'use strict';

	var toArray = require('../utils/toArray');

	function merge() {
		var objs = toArray(arguments);
		var r = {};
		objs.forEach( function (obj) {
			Object.keys(obj).forEach( function (key) {
				r[key] = obj[key];
			});
		});
		return r;
	}

	return merge;

});
