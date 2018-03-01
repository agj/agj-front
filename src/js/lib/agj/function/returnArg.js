
define( function (require) {
	'use strict';
	
	var overload = require('./overload');
	var is = require('../is');

	function doReturnArg(argIndex, fn) {
		return function returnArged() {
			fn.apply(this, arguments);
			return arguments[argIndex];
		};
	}

	var returnArg = overload(
		[[is.fn], function (fn) {
			return doReturnArg(0, fn);
		}],
		[[is.number, is.fn, overload.REST], doReturnArg],
		[[is.number], function (argIndex) {
			return function (fn) {
				return doReturnArg(argIndex, fn);
			};
		}]
	);

	return returnArg;

});
