/**
 * Method for creating 'classes', based on John Resig's.
 * Expanded to support '_super' method calls that properly go up the inheritance chain, and statics.
 */
define( function (require) {
	'use strict';

	var is = require('../is');
	var to = require('../to');
	var not = require('../function/not');
	var mixin = require('../utils/mixin');
	var map = require('../collection/map');
	var filter = require('../collection/filter');
	var promoteArg = require('../function/promoteArg');

	var module = function Class() {};

	var classInitializing = false;
	var classUsesSuperTest = /xyz/.test(function(){ 'xyz'; }) ? /\b_super\b/ : null;

	module.extend = function (properties) {
		classInitializing = true;
		var prototype = new this();
		classInitializing = false;

		var _super = this.prototype;

		properties.init = properties.init || function() {};
		var _cast = properties.cast || function(v) {
			if (v instanceof Class) return v;
			throw new TypeError("Invalid type casting.");
		};
		delete properties.cast;

		mixin(prototype, map(
			filter(properties, promoteArg(1, not(is.in(['statics', 'mixins'])))),
			function (value) {
				if (is.fn(value) && (!classUsesSuperTest || classUsesSuperTest.test(value)))
					return superify(value, superFn);
				return value;
			}
		));
		if (properties.mixins) properties.mixins.forEach(mixin(prototype));
		if (properties.statics) mixin(Class, properties.statics);
		properties = null;

		function superFn(name) {
			var scope = this;
			return function fromSuper() {
				_super[name].apply(scope, arguments);
			};
		}

		function Class() {
			if (this instanceof Class) {
				// Instance construction.
				if (!classInitializing)
					prototype.init.apply(this, arguments);
			} else {
				// Type casting.
				if (arguments.length === 1)
					return _cast(arguments[0]);
				throw new Error("Invalid type casting.");
			}
		}

		Class.prototype = prototype;
		Class.prototype.constructor = Class;

		Class.extend = module.extend;

		return Class;
	};

	function superify(fn, superFn) {
		return function superified() {
			var originalSuper = this._super;
			this._super = superFn;
			var result = fn.apply(this, arguments);
			this._super = originalSuper;
			return result;
		};
	}

	return module;

});
