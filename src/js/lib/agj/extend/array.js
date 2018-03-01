
define( function (require) {
	'use strict';

	var is = require('../is');
	var extend = require('../extend');
	var extendUtils = require('./utils/utils');

	var proto = extendUtils.constructProto(
		Array.prototype,
		['pop', 'push', 'reverse', 'shift', 'splice', 'unshift']
	);

	extendUtils.addUtils(proto, require('../array'));

	extendUtils.addMethods(proto, {
		get: function (index) {
			return this[index];
		},
		set: function (index, value) {
			this[index] = value;
			return this;
		},
	});

	extendUtils.addGetters(proto, ['length']);

	return extend.register({
		approve: is.array,
		proto: proto
	});
	
});
