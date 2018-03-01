
define( function (require) {
	'use strict';

	var clone = require('./clone');
	var randomInt = require('../random/integer');

	function shuffle(arr) {
		var result = [];
		var remaining = clone(arr);
		var i = arr.length + 1;
		while (--i > 0) {
			var current = randomInt(i);
			result.push(remaining[current]);
			remaining.splice(current, 1);
		}
		return result;
	}

	return shuffle;
	
});
