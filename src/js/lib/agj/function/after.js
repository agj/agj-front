
define( function (require) {
	'use strict';

	var autoCurry = require('./autoCurry');

	var after = autoCurry( function after(decoration, target) {
		return function () {
			var r = target.apply(this, arguments);
			decoration.call(this, r);
			return r;
		};
	});

	return after;

});
