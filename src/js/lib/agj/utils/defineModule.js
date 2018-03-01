
define(function (require) {
	'use strict';

	var autoCurry = require('../function/autoCurry');

	var defineModule = autoCurry( function defineModule(target, stringName, value) {
		if (!target) throw new TypeError('Invalid object passed.');

		var modules = stringName.split('.');
		var len = modules.length;
		modules.forEach( function (modName, i) {
			if (!(modName in target)) {
				var curValue = (value !== void 0 && i === len - 1) ? value : {};
				Object.defineProperty(target, modName, {
					writable: false, enumerable: true, configurable: false,
					value: curValue
				});
			}
			target = target[modName];
		});

		return value || target;
	});

	return defineModule;

});
