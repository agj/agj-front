
define( function (require) {
	'use strict';

	var is = require('../is');
	var extend = require('../extend');
	var extendUtils = require('./utils/utils');
	var fn = require('../function');

	var fixedFn = {
		after:           fn.promoteArgSolid(1, fn.after),
		autoCurry:       fn.promoteArgSolid(1, fn.autoCurry),
		before:          fn.promoteArgSolid(1, fn.before),
		compose:         fn.compose,
		fixArity:        fn.promoteArgSolid(1, fn.fixArity),
		flip:            fn.promoteArgSolid(1, fn.flip),
		iterate:         fn.promoteArgSolid(2, fn.iterate),
		maybe:           fn.promoteArgSolid(2, fn.maybe),
		memoize:         fn.memoize,
		not:             fn.not,
		parameters:      fn.parameters,
		partial:         fn.partial,
		pipe:            fn.pipe,
		promoteArg:      fn.promoteArgSolid(1, fn.promoteArg),
		promoteArgSolid: fn.promoteArgSolid(1, fn.promoteArgSolid),
		returnArg:       fn.promoteArgSolid(1, fn.returnArg),
		returnThis:      fn.returnThis,
		sequence:        fn.sequence,
		variadic:        fn.promoteArgSolid(1, fn.variadic)
	};

	var proto = extendUtils.constructProto(Function.prototype);

	extendUtils.addUtils(proto, fixedFn);

	extendUtils.addGetters(proto, ['length']);

	return extend.register({
		approve: is.fn,
		proto: proto
	});
	
});
