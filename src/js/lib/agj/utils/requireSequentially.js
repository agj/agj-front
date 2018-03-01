/**
 * @requires rsvp
 */
define( function (require) {
	'use strict';

	var rsvp = require('rsvp');
	var toArray = require('./toArray');
	var promiseRequire = require('./promiseRequire');

	function requireSequentially() {
		return toArray(arguments).reduce( function (promise, dependency) {
			return promise.then( function () {
				return promiseRequire([dependency]);
			});
		}, rsvp.resolve());
	}

	return requireSequentially;

});
