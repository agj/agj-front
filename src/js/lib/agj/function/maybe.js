/**
 * Decorates a function so that it is called only if the first supplied parameter
 * satisfies the predicate.
 *
 * It is auto-curried so that you may pass one or two arguments, and it will
 * return another function. If you pass two arguments and both are functions,
 * it will execute (with no elseValue), so if you need an elseValue that is a
 * function, you'll need to pass first one and then two arguments, or three all
 * at the same time.
 *
 * @param  {function} predicate    Function that takes one argument and returns
 *                                 a boolean indicating if the supplied argument
 *                                 is satisfactory.
 * @param             [elseValue]  Optional value to return if predicate fails.
 * @param  {function} fn           Function to be called with supplied argument
 *                                 if predicate returns true.
 * @return {function}
 */
define( function (require) {
	'use strict';

	var isFn      = require('../is').fn;

	function maybe(predicate, elseValue, fn) {
		if (arguments.length >= 3)  return uncurriedMaybe(predicate, elseValue, fn);
		if (arguments.length === 2) return curryingMaybe2(elseValue);
		if (arguments.length === 1) return curryingMaybe2;
		return maybe;

		function curryingMaybe2(elseValue, fn) {
			if (arguments.length >= 2) return uncurriedMaybe(predicate, elseValue, fn);
			if (arguments.length == 1) {
				if (isFn(elseValue)) return uncurriedMaybe(predicate, void 0, elseValue);
				return function curryingMaybe1(fn) {
					if (arguments.length >= 1) return uncurriedMaybe(predicate, elseValue, fn);
					return curryingMaybe1;
				};
			}
			return curryingMaybe2;
		}
	}

	function uncurriedMaybe(predicate, elseValue, fn) {
		return function maybed(v) {
			if (predicate(v)) return fn.apply(this, arguments);
			return elseValue;
		};
	}

	return maybe;

});
