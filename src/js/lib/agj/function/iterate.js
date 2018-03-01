/**
 * Loops the passed function according to the supplied arguments.
 * Break by returning a truthy value. This value will in turn be returned
 * by the function.
 *
 * loop(fn)                       Loops indefinitely.
 * loop(endIndex, fn)             Loops from 0 to endIndex, the latter non-inclusive.
 * loop(startIndex, endIndex, fn) Loops from startIndex to endIndex, the latter
 *                                non-inclusive. Accepts a larger startIndex to loop
 *                                in reverse.
 *
 * The supplied function will be called with the following signature:
 *
 * fn(currentIndex, endIndex, startIndex)
 */
define( function (require) {
	'use strict';

	var overload = require('./overload');
	var is = require('../is');

	function doIterate(startIndex, endIndex, fn) {
		var dir = startIndex > endIndex ? -1 : 1;
		var i = 0;
		var end = dir > 0 ? endIndex - startIndex : startIndex - endIndex;
		while (i < end) {
			var r = fn(startIndex + i * dir, endIndex, startIndex);
			if (is.set(r)) return r;
			i++;
		}
	}

	var iterate = overload(
		[[is.fn, overload.REST], function (fn) {
			return doIterate(0, Infinity, fn);
		}],
		[[is.number, is.fn, overload.REST], function (endIndex, fn) {
			return doIterate(0, endIndex, fn);
		}],
		doIterate
	);

	return iterate;

});
