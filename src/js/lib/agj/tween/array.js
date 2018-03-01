/**
 * @requires rsvp
 * @requires signals
 */
define( function (require) {
	'use strict';

	var liveArray = require('./liveArray');
	var clone = require('../array/clone');

	/**
	 * Creates an array of numbers that tweens to the desired state. The startState and endState arrays
	 * define definite start and end states; modifying these later will not affect the tween.
	 * See liveArray for such functionality.
	 *
	 * @param {Number}   [mspf]   Milliseconds per frame.
	 * @param {Function} [easing] Function that takes a number (0..1) and returns another value in the range.
	 *
	 * @returns {Object}          { result: Array, progress: Number, updated: Signal, finished: Promise, stop: Function }
	 */
	function array(startValue, endValue, duration, mspf, easing) {
		return liveArray(clone(startValue), clone(endValue), duration, mspf, easing);
	}

	return array;

});
