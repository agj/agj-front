
define( function (require) {
	'use strict';

	function bindMethod(obj, methodName) {
		return obj[methodName].bind(obj);
	}

	return bindMethod;

});
