
define( function (require) {
	'use strict';

	var overload = require('../function/overload');
	var is = require('../is');

	function doLogBase(num, base) {
		return Math.log(num) / Math.log(base);
	}

	var logBase = overload(
		[[is.number], function (base) {
			return function (num) {
				return doLogBase(num, base);
			};
		}],
		doLogBase
	);

	return logBase;

});
