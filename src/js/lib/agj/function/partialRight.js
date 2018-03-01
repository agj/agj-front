
define( function (require) {
	'use strict';

	var overload = require('./overload');
	var rest = overload.REST;
	var partial = require('./partial');
	var promoteArg = require('./promoteArg');
	var flip = require('./flip');
	var first = require('../array/first');
	var last = require('../array/last');
	var toArray = require('../utils/toArray');
	var is = require('../is');

	function doPartialRight(arity, fn, args) {
		if (args.length > arity) args = first(args, arity);
		var splitIndex = Math.max(0, arity - args.length);
		return function () {
			var current = toArray(arguments);
			var before = first(current, splitIndex);
			before.length = splitIndex;
			return fn.apply(this, before.concat(args));
		};
	}

	var isArity = is.number;
	var isFn = is.fn;
	var isArgs = is.array;

	var partialRight = overload(
		// Three arguments.
		[[isArity, isFn, isArgs, rest], doPartialRight],
		[[isArity, isArgs, isFn, rest], function (arity, args, fn) {
			return doPartialRight(arity, fn, args);
		}],
		[[isFn, isArity, isArgs, rest], promoteArg(1, doPartialRight)],
		[[isFn, isArgs, isArity, rest], function (fn, args, arity) {
			return doPartialRight(arity, fn, args);
		}],
		[[isArgs, isArity, isFn, rest], promoteArg(2, doPartialRight)],
		[[isArgs, isFn, isArity, rest], flip(doPartialRight)],

		// Two arguments.
		[[isFn, isArgs], function (fn, args) {
			return doPartialRight(fn.length, fn, args);
		}],
		[[isArgs, isFn], function (args, fn) {
			return doPartialRight(fn.length, fn, args);
		}],
		[[isArity, isFn], function (arity, fn) {
			return partial(doPartialRight, [arity, fn]);
		}],
		[[isFn, isArity], function (fn, arity) {
			return partial(doPartialRight, [arity, fn]);
		}],
		[[isArity, isArgs], function (arity, args) {
			return doPartialRight(3, promoteArg(1, doPartialRight), [arity, args]);
		}],
		[[isArgs, isArity], function (args, arity) {
			return doPartialRight(3, promoteArg(1, doPartialRight), [arity, args]);
		}],

		// One argument.
		[[isFn], function (fn) {
			return partial(doPartialRight, [fn.length, fn]);
		}],
		[[isArgs], function (args) {
			return overload(
				[[isArity, isFn, rest], doPartialRight(3, doPartialRight, [args])],
				[[isFn, isArity, rest], doPartialRight(3, promoteArg(1, doPartialRight), [args])],
				[[isFn], function (fn) {
					return doPartialRight(fn.length, fn, args);
				}],
				[[isArity], function (arity) {
					return partial(promoteArg(2, doPartialRight), [args, arity]);
				}]
			);
		}],
		[[isArity], function (arity) {
			return overload(
				[[isFn, isArgs, rest], partial(doPartialRight, [arity])],
				[[isArgs, isFn, rest], promoteArg(1, partial(doPartialRight, [arity]))],
				[[isFn], function (fn) {
					return partial(doPartialRight, [arity, fn]);
				}],
				[[isArgs], function (args) {
					return partial(promoteArg(2, doPartialRight), [args, arity]);
				}]
			);
		}]
	);

	return partialRight;

});
