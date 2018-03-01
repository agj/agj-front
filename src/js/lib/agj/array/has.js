
define( function (require) {
	'use strict';

	var autoCurry = require('../function/autoCurry');

	var has = autoCurry( function (item, arr) {
		return arr.indexOf(item) !== -1;
	});

	return has;
	
});
