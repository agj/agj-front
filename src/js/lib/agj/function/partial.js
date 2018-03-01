
define( function (require) {
	'use strict';

	var overload = require('./overload');
	var promoteArg = require('./promoteArg');
	var toArray = require('../utils/toArray');
	var is = require('../is');

	function doPartial(fn, args) {
		return function () {
			return fn.apply(this, args.concat(toArray(arguments)));
		};
	}

	var partial = overload(
		[[is.fn, is.set, overload.REST], doPartial],
		[[is.fn], function (fn) {
			return doPartial(doPartial, [fn]);
		}],
		[[is.set], function (args) {
			return function (fn) {
				return doPartial(fn, args);
			};
		}],
		[[is.set, is.fn, overload.REST], promoteArg(1, doPartial)]
	);

	return partial;

});
