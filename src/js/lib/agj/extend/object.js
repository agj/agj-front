
define( function (require) {
	'use strict';

	var is = require('../is');
	var extend = require('../extend');
	var extendUtils = require('./utils/utils');
	var mergeInto = require('../object/mergeInto');

	var proto = {};

	var forbiddenMethods = ['constructor', 'prototype'];
	Object.getOwnPropertyNames(Object).forEach( function (name) {
		if (is.fn(Object[name]) && name.charAt(0) !== '_' && forbiddenMethods.indexOf(name) === -1) {
			proto[name] = extendUtils.argToThis(Object[name]);
		}
	});

	mergeInto(proto, extendUtils.constructProto(Object.prototype));

	extendUtils.addUtils(proto, require('../object'));

	extendUtils.addMethods(proto, {
		get: function (key) {
			return this[key];
		},
		set: function (key, value) {
			this[key] = value;
			return this;
		}
	});

	return extend.register({
		approve: is.objectLiteral,
		proto: proto
	});
	
});
