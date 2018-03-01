
define( function (require) {
	'use strict';

	return {
		after:           require('./function/after'),
		autoCurry:       require('./function/autoCurry'),
		// autoCurryArityFn
		before:          require('./function/before'),
		compose:         require('./function/compose'),
		fixArity:        require('./function/fixArity'),
		flip:            require('./function/flip'),
		iterate:         require('./function/iterate'),
		maybe:           require('./function/maybe'),
		memoize:         require('./function/memoize'),
		not:             require('./function/not'),
		parameters:      require('./function/parameters'),
		partial:         require('./function/partial'),
		pipe:            require('./function/pipe'),
		promoteArg:      require('./function/promoteArg'),
		promoteArgSolid: require('./function/promoteArgSolid'),
		returnArg:       require('./function/returnArg'),
		returnThis:      require('./function/returnThis'),
		sequence:        require('./function/sequence'),
		variadic:        require('./function/variadic'),
	};

});
