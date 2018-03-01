
define( function (require) {
	'use strict';

	var toArray = require('../utils/toArray');

	function sequence() {
		var fns = toArray(arguments);
		return function sequenced() {
			var fnsCopy = fns.slice();
			return fnsCopy.reduce(process, fnsCopy.shift().apply(this, arguments));
		};
	}

	function process(r, fn) {
		return fn(r);
	}

	return sequence;

});
