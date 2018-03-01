
define( function (require) {
	'use strict';

	var autoCurry = require('./autoCurry');

	var before = autoCurry( function before(decoration, target) {
		return function () {
			decoration.apply(this, arguments);
			return target.apply(this, arguments);
		};
	});

	return before;

});
