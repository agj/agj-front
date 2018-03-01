
define( function (require) {
	'use strict';

	var toArray = require('../utils/toArray');

	function compose() {
		var fns = toArray(arguments);
		return function composed() {
			var fnsCopy = fns.slice();
			return fnsCopy.reduceRight(process, fnsCopy.pop().apply(this, arguments));
		};
	}

	function process(r, fn) {
		return fn(r);
	}

	return compose;

});
