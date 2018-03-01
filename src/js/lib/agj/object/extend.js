
define( function (require) {
	'use strict';

	var autoCurry = require('../function/autoCurry');

	var extend = autoCurry(function (target, source) {
		Object.keys(source).forEach( function (key) {
			target[key] = source[key];
		});
		return target;
	});

	return extend;

});
