
define( function (require) {
	'use strict';

	var is = require('../is');
	var extend = require('../extend');
	var extendUtils = require('./utils/utils');

	var proto = extendUtils.constructProto(String.prototype);

	extendUtils.addUtils(proto, require('../string'));

	extendUtils.addGetters(proto, ['length']);

	return extend.register({
		approve: is.string,
		proto: proto
	});
	
});
