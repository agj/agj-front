
define( function (require) {
	'use strict';

	var nextOrPrevIndex = require('./nextOrPrevIndex');

	function prevTo(arr, item, dontWrapAround) {
		var index = nextOrPrevIndex(arr, arr.indexOf(item), false, dontWrapAround);
		if (index >= 0)
			return arr[index];
		return void 0;
	}

	return prevTo;
	
});
