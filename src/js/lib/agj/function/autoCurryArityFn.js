
define( function (require) {
	'use strict';

	var overload = require('./overload');

	function isFn(obj) {
		return typeof obj === 'function';
	}
	function isArity(obj) {
		return typeof obj === 'number';
	}

	function autoCurryArityFn(target) {
		return overload(
			[[isFn], function (fn) {
				return target(fn.length, fn);
			}],
			[[isArity, isFn, overload.REST], target],
			[[isFn, isArity, overload.REST], function (fn, arity) {
				return target(arity, fn);
			}],
			[[isArity], function (arity) {
				return function (fn) {
					return target(arity, fn);
				};
			}],
			target
		);
	}

	return autoCurryArityFn;

});
