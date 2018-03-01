
define( function (require) {
	'use strict';

	var extend = require('./extend');
	var autoCurry = require('../function/autoCurry');

	var adopt = autoCurry(function (source, target) {
		return extend(target, source);
	});

	return adopt;

});
