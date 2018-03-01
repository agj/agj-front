/**
 * Same as promoteArg, but the argIndex is not enforced if not enough arguments are passed.
 * Instead, the promoted argument is passed to the original function immediately following
 * the previously passed argument.
 */
define( function (require) {
	'use strict';

	var toArray = require('../utils/toArray');

	function promoteArgSolid(argIndex, fn) {
		return function argPromoted() {
			var args = toArray(arguments, 1);
			var promotedArg = arguments[0];
			args.splice(argIndex, 0, promotedArg);
			return fn.apply(this, args);
		};
	}

	return promoteArgSolid;

});
