/**
 * @requires rsvp
 */
define( function (require) {
	'use strict';

	var rsvp = require('rsvp');

	function promiseRequire(dependencies) {
		var deferred = rsvp.defer();
		require(dependencies, function () { deferred.resolve(true); });
		return deferred.promise;
	}

	return promiseRequire;

});
