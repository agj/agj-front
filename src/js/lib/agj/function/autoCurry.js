
define( function (require) {
	'use strict';

	var autoCurryArityFn = require('./autoCurryArityFn');
	var toArray = require('../utils/toArray');

	function autoCurryTo(arity, fn) {
		if (arity === 0) return fn;
		return function autoCurried() {
			if (arguments.length >= arity) {
				return fn.apply(this, arguments);
			} else {
				var args = toArray(arguments);
				return autoCurryTo(arity - args.length, function autoCurriedRest() {
					return fn.apply(this, args.concat( toArray(arguments) ));
				} );
			}
		};
	}

	var autoCurry = autoCurryArityFn(autoCurryTo);

	return autoCurry;

});
