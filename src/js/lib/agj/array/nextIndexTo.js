
define( function (require) {
	'use strict';

	var nextOrPrevIndex = require('./nextOrPrevIndex');

	function nextIndexTo(arr, item, dontWrapAround) {
		return nextOrPrevIndex(arr, arr.lastIndexOf(item), true, dontWrapAround);
	}

	return nextIndexTo;
	
});
