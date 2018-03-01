
define( function (require) {
	'use strict';

	function nextOrPrevIndex(arr, index, getNext, dontWrapAround) {
		index += getNext ? 1 : -1;
		var len = arr.length;
		if (index >= len) {
			if (!dontWrapAround)
				index = index % len;
			else
				index = -1;
		} else if (index < 0) {
			if (!dontWrapAround)
				index += len;
			else
				index = -1;
		}
		return index;
	}

	return nextOrPrevIndex;
	
});
