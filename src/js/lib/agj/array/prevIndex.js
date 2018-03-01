
define( function (require) {
	'use strict';

	var nextOrPrevIndex = require('./nextOrPrevIndex');

	function prevIndex(arr, index, dontWrapAround) {
		return nextOrPrevIndex(arr, index, false, dontWrapAround);
	}

	return prevIndex;
	
});
