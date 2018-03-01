
define(function (require) {
	'use strict';

	function call(methodName, args) {
		args = args || [];
		return function call(v) { return v[methodName].apply(v, args); };
	}

	function id(v) { return v; }

	function prop(name) { return function prop(v) { return v[name]; }; }

	function value(v) { return function value() { return v; }; }

	return {
		call: call,
		id: id,
		prop: prop,
		value: value,
	};

});
