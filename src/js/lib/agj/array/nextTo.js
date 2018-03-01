
define( function (require) {
	'use strict';

	var nextOrPrevIndex = require('./nextOrPrevIndex');

	function nextTo(arr, item, dontWrapAround) {
		var index = nextOrPrevIndex(arr, arr.lastIndexOf(item), true, dontWrapAround);
		if (index >= 0)
			return arr[index];
		return void 0;
	}

	return nextTo;
	
});
