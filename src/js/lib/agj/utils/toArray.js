
define( function () {
	'use strict';

	return Function.prototype.call.bind(Array.prototype.slice); // Can still pass in parameters if we need only a subset of the indices!

});
