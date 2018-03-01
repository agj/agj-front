
define( function (require) {
	'use strict';

	var is = require('../is');
	var extend = require('../extend');
	var extendUtils = require('./utils/utils');

	var proto = extendUtils.constructProto(Number.prototype);

	extendUtils.addUtils(proto, require('../number'));

	return extend.register({
		approve: is.number,
		proto: proto
	});
	
});
