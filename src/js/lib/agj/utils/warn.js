
define(function (require) {
	'use strict';

	var warn = console && console.warn ? console.warn.bind(console) : console && console.log ? console.log.bind(console) : function () {};

	return warn;

});
