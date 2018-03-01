
define( function (require) {
	'use strict';

	var overload = require('../function/overload');
	var is = require('../is');

	function doInBase(num, base, pad) {
		var result = num.toString(base);
		if (!isNaN(pad)) {
			while (result.length < pad) {
				result = '0' + result;
			}
		}
		return result;
	}

	var inBase = overload(
		[[is.number], function (base) {
			return function (num, pad) {
				return doInBase(num, base, pad);
			};
		}],
		doInBase
	);

	return inBase;

});