
define( function (require) {
	'use strict';

	var to = require('../to');
	var sequence = require('../function/sequence');

	var get = to.prop;
	var call = to.call;

	function setElseDo(v, els, fn) {
		if (v) return fn(v);
		return els;
	}

	var findParameters = sequence(call('toString'), call('match', [/^function \w*\s?\(([^\)\/]*)/]));
	var splitTrimAndFilter = sequence(get(1), call('split', [',']), call('map', [call('trim')]), call('filter', [to.id]));

	function parameters(fn) {
		return setElseDo(findParameters(fn), [], splitTrimAndFilter);
	}

	return parameters;

});
