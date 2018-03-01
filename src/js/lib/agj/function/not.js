/**
 * Decorates a function so that it is called only if the first supplied parameter
 * satisfies the predicate.
 */
define( function (require) {
	'use strict';

	function not(fn) {
		return function notted(v) {
			return !fn(v);
		};
	}

	return not;

});
