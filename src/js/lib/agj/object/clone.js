
define( function (require) {
	'use strict';

	var merge = require('./merge');
	var partial = require('../function/partial');

	return partial(merge, [{}]);

});
