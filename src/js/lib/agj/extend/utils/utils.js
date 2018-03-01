
define( function (require) {
	'use strict';

	var isFn = require('../../is').fn;
	var toArray = require('../../utils/toArray');
	var mergeInto = require('../../object/mergeInto');
	var map = require('../../collection/map');
	var returnThis = require('../../function/returnThis');

	var forbiddenMethods = ['constructor', 'prototype'];

	function constructProto(source, returnThisList) {
		var result = Object.create(source);

		Object.getOwnPropertyNames(source).forEach( function (name) {
			if (name.charAt(0) === '_' || forbiddenMethods.indexOf(name) !== -1 || !isFn(source[name])) return;
			result[name] = (!returnThisList || returnThisList.indexOf(name) === -1) ? source[name] : returnThis(source[name]);
		});

		return result;
	}

	function addUtils(target, utils) {
		mergeInto(target, map(utils, function (fn) {
			return argToThis(fn);
		}));
	}

	function addMethods(target, methods) {
		mergeInto(target, methods);
	}

	function addGetters(target, getters) {
		getters.forEach( function (name) {
			Object.defineProperty(target, name, {
				enumerable: true,
				get: toGetter(name)
			});
		});
	}

	function argToThis(fn) {
		return function argToThis() {
			return fn.apply(null, [this].concat(toArray(arguments)));
		};
	}

	function toGetter(prop) {
		return function () {
			return this[prop];
		};
	}

	return {
		constructProto: constructProto,
		argToThis:      argToThis,
		addUtils:       addUtils,
		addMethods:     addMethods,
		addGetters:     addGetters,
	};
	
});
