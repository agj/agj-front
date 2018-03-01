
define(function (require) {
	'use strict';

	function destroy(arrayOfDestroyables) {
		for (var i = 0, len = arrayOfDestroyables.length; i < len; i++) {
			var current = arrayOfDestroyables[i];
			if (!current)
				continue;
			if (isArray(current))
				agj.destroy(current);
			else if (current.destroy)
				current.destroy();
			else if (current.removeAll)
				current.removeAll();
		}
	}

	return destroy;

});
