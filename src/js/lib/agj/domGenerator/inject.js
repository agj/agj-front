
define( function (require) {
	'use strict';

	var parameters = require('../function/parameters');
	var toEl = require('./toEl');

	function inject(fn) {
		var tags = parameters(fn).map(paramToTagName).map(toEl);
		return fn.apply(null, tags);
	}

	function paramToTagName(paramName) {
		return paramName
			.replace(/([A-Z])/g, '-$1')
			.replace(/(_)/g, ':')
			.toLowerCase();
	}

	return inject;

});
