/**
 * @requires rsvp
 * @requires signals
 */
define( function (require) {
	'use strict';

	var RSVP = require('rsvp');
	var signals = require('signals');
	var clone = require('../array/clone');
	var easingFns = require('./easing');

	/**
	 * Creates an array of numbers that tweens to the desired state. Both the startState and endState are
	 * arrays whose values may change even as the tween progresses. This means that you can use liveArrays
	 * for these values, in order to compose tweens.
	 *
	 * @param {Array}    startState An array of numbers, indicating a start state for the tween.
	 * @param {Array}    endState   An array of numbers, indicating the target state for the tween.
	 * @param {Number}   [duration] Milliseconds.
	 * @param {Number}   [mspf]     Milliseconds per frame.
	 * @param {Function} [easing]   Function that takes a number (0..1) and returns another number (0..1).
	 *
	 * @returns {Object}          { result: Array, progress: Number, updated: Signal [result, progress], finished: Promise, stop: Function }
	 */
	function liveArray(startState, endState, duration, mspf, easing) {
		var deferred = RSVP.defer();
		var result = clone(startState);
		var updated = new signals.Signal();
		var stop = function () {
			if (!isFinished) {
				isFinished = true;
				updated.removeAll();
				deferred.resolve(result);
			}
		};

		var isFinished = false;
		duration = duration || 500;
		mspf = mspf || 20;
		easing = easing || easingFns.linear;
		var startTime = Date.now();

		var execute = function () {
			if (isFinished) return;

			var progress = r.progress = (Date.now() - startTime) / duration;
			var i = startState.length;
			if (progress < 1) {
				var p = easing(progress);
				while (--i >= 0) {
					result[i] = startState[i] * (1 - p) + endState[i] * p;
				}
				updated.dispatch(result, r.progress);
				setTimeout(execute, mspf);
			} else {
				while (--i >= 0) {
					result[i] = endState[i];
				}
				r.progress = 1;
				updated.dispatch(result, r.progress);
				stop();
			}
		};
		setTimeout(execute, mspf);

		var r = {
			result: result,
			progress: 0,
			updated: updated,
			finished: deferred.promise,
			stop: stop,
		};
		return r;
	}

	return liveArray;

});
