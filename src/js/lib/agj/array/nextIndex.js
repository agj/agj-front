
define( function (require) {
	'use strict';

	var nextOrPrevIndex = require('./nextOrPrevIndex');

	function nextIndex(arr, index, dontWrapAround) {
		return nextOrPrevIndex(arr, index, true, dontWrapAround);
	}

	return nextIndex;
	
});
