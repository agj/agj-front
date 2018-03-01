
define( function (require) {
	'use strict';

	var isFn = require('../is').fn;

	function pipe(fn) {
		var prev = this;
		function piped() {
			if (isFn(prev))
				return fn(prev.apply(null, arguments));
			else
				return fn.apply(null, arguments);
		}
		piped.pipe = piped.to = pipe;
		return piped;
	}


	return pipe;

});
