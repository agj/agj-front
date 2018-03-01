
define( function (require) {
	'use strict';

	var autoCurry = require('../function/autoCurry');

	var mixin = autoCurry( function mixin(target, properties) {
		for (var prop in properties) {
			if (!properties.hasOwnProperty(prop)) continue;
			if (target.hasOwnProperty(prop) && target[prop] !== void 0) continue;
			Object.defineProperty(target, prop, {
				writable: true, enumerable: false, configurable: true,
				value: properties[prop]
			});
		}

		return target;
	});

	return mixin;

});
