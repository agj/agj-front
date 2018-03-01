
define( function (require) {
	'use strict';

	var toArray = require('../utils/toArray');

	function isFn(obj) {
		return typeof obj === 'function';
	}

	function last(array) {
		return array[array.length - 1];
	}

	function overload(target, predicates, over) {
		if (isFn(target)) {
			var allowsRest = last(predicates) === REST;
			return function overloaded() {
				if (!allowsRest && arguments.length !== predicates.length) return target.apply(this, arguments);
				var i = -1;
				var len = predicates.length;
				while (++i < len) {
					var predicate = predicates[i];
					if (allowsRest && predicate === REST) break;
					if (!predicate(arguments[i])) return target.apply(this, arguments);
				}
				return over.apply(this, arguments);
			};
		}

		var current = last(arguments);
		var list = isFn(current) ? toArray(arguments, 0, -1) : toArray(arguments);
		if (!isFn(current)) current = function () { throw new Error("Illegal arguments passed to function."); };

		var i = list.length;
		while (--i >= 0) {
			current = overload(current, list[i][0], list[i][1]);
		}

		return current;
	}

	var REST = {};
	Object.defineProperty(overload, 'REST', { value: REST });

	return overload;

});
