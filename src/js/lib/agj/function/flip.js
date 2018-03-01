
define( function (require) {
	'use strict';

	var toArray = require('../utils/toArray');
	var autoCurryArityFn = require('./autoCurryArityFn');

	var flip = autoCurryArityFn( function flip(arity, fn) {
		return function flipped() {
			var args = toArray(arguments, 0, arity);
			args.reverse();
			args = ( new Array(Math.max(0, arity - arguments.length)) ).concat(args);
			return fn.apply(this, args);
		};
	});

	return flip;

});
