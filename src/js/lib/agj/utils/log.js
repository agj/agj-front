
define(function (require) {
	'use strict';

	var log = console && console.log ? console.log.bind(console) : function () {};
	// function log() {
	// 	if (console && console.log)
	// 		console.log.apply(console, toArray(arguments));
	// };

	return log;

});
