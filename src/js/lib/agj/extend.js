
define(function (require) {
	'use strict';

	var Dictionary = require('./datastructures/Dictionary');
	var Class = require('./class/Class');
	var isFn = require('./is').fn;
	var to = require('./to');

	var moduleCache = new Dictionary();

	function extend(obj) { throw new Error("No modules registered. Use extend.register(module) and use the returned extend function."); }
	extend.register = register;

	function register(module) {
		var scope = new Scope();
		scope.addModule(module);

		function extend(obj, ignoreIfCantExtend) {
			var mod = scope.getMatchingModule(obj);
			if (!mod) {
				if (ignoreIfCantExtend !== true) throw new TypeError("Passed object is not compatible with any registered modules.");
				return obj;
			}
			var result = Object.create(mod.proto);
			result.value = obj;
			return result;
		}
		extend.register = function reg(m) {
			if (m.register) return m.register(scope);
			if (m instanceof Scope) scope.incorporate(m);
			else scope.addModule(module);
			return extend;
		};
		scope.extend = extend;
		return extend;
	}

	var Scope = Class.extend({
		init: function Scope() {
			this.modules = [];
		},
		addModule: function (module) {
			this.modules.push(this.processModule(module));
		},
		incorporate: function (scope) {
			this.modules = this.modules.concat(scope.modules);
		},
		getMatchingModule: function (obj) {
			return this.modules.filter( function (mod) { return mod.approve(obj); })[0];
		},
		processModule: function (module) {
			var result = moduleCache.get(module);
			if (result) return result;

			result = { approve: module.approve };
			var p = Object.getPrototypeOf(module.proto);
			var proto = Object.create(p);
			Object.keys(module.proto).forEach( function (name) {
				var desc = Object.getOwnPropertyDescriptor(module.proto, name);
				if (desc.value) desc.value = this.processMethod(desc.value);
				if (desc.get)   desc.get   = this.processMethod(desc.get);
				if (desc.set)   desc.set   = this.processMethod(desc.set);
				Object.defineProperty(proto, name, desc);
			}.bind(this));
			proto.toString = function () {
				return p.toString.apply(this.value, arguments);
			};
			proto.valueOf = function () {
				return p.valueOf.apply(this.value, arguments);
			};
			result.proto = proto;

			moduleCache.set(module, result);
			return result;
		},
		processMethod: function (fn) {
			if (!isFn(fn)) return fn;
			var scope = this;
			return function () {
				return scope.extend(fn.apply(this.value, arguments), true);
			};
		}
	});

	return extend;

});
