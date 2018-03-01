
define( function (require) {
	'use strict';

	var autoCurry = require('../function/autoCurry');

	var within = autoCurry( function (arr, item) {
		return arr.indexOf(item) !== -1;
	});

	return within;
	
});
