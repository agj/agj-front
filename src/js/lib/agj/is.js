
define( function (require) {
	'use strict';

	var autoCurry = require('./function/autoCurry');
	var values = require('./object/values');
	var objIsEmpty = require('./object/isEmpty');

	var isArray = require('./is/array');


	var toString = Object.prototype.toString.call.bind(Object.prototype.toString);

	function exists(object) {
		return object !== void 0 && object !== null && (typeof object !== 'number' || !isNaN(object));
	}

	function set(object) {
		return exists(object) && object !== '';
	}

	function empty(object) {
		return !set(object) ||
			(isArray(object) && object.length === 0) ||
			(objectLiteral(object) && objIsEmpty(object));
	}

	function undef(object) {
		return object === void 0;
	}

	function boolean(object) {
		return typeof object === 'boolean';
	}

	function number(object) {
		return toString(object) === '[object Number]';
	}

	function string(object) {
		return toString(object) === '[object String]';
	}

	function fn(object) {
		return typeof object === 'function';
	}

	function date(object) {
		return toString(object) === '[object Date]';
	}

	function objectLiteral(object) {
		return !!object && typeof object === 'object' && Object.getPrototypeOf(object) === Object.prototype;
	}

	var instanceOf = autoCurry(function instanceOf(type, object) { return object instanceof type; });

	var equal          = autoCurry(function equal(a, b) { return b === a; });

	var greater        = autoCurry(function greater(a, b) { return b > a; });

	var greaterOrEqual = autoCurry(function greaterOrEqual(a, b) { return b >= a; });

	var less           = autoCurry(function less(a, b) { return b < a; });

	var lessOrEqual    = autoCurry(function lessOrEqual(a, b) { return b <= a; });

	var isIn = autoCurry(function isIn(container, item) {
		if (isArray(container)) return container.indexOf(item) !== -1;
		if (objectLiteral(container)) return values(container).indexOf(item) !== -1;
		throw new TypeError("Container is neither an array nor an object literal.");
	});


	return {
		boolean: boolean,
		array: isArray,
		date: date,
		empty: empty,
		exists: exists,
		eq: equal,
		equal: equal,
		fn: fn,
		greater: greater,
		greaterOrEqual: greaterOrEqual,
		gt: greater,
		gte: greaterOrEqual,
		in: isIn,
		instanceOf: instanceOf,
		less: less,
		lessOrEqual: lessOrEqual,
		lt: less,
		lte: lessOrEqual,
		number: number,
		objectLiteral: objectLiteral,
		set: set,
		string: string,
		undefined: undef,
	};

});
