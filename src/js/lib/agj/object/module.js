
define( function (require) {
	'use strict';

	var is = require('../is');
	var overload = require('../function/overload');
	var not = require('../function/not');
	var autoCurry = require('../function/autoCurry');

	function singleModule(target, property, value) {
		Object.defineProperty(target, property, {
			value: value,
			writable: false, enumerable: true, configurable: false,
		});
		return value;
	}

	function modules(target, values) {
		Object.keys(values).forEach( function (property) {
			singleModule(target, property, values[property]);
		});
		return target;
	}

	var module = autoCurry(2, overload(
		[[is.set, not(is.string)], modules],
		[[is.set, is.string, not(is.undefined)], singleModule]
	));

	return module;

});
