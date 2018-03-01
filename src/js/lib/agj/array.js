
define( function (require) {
	'use strict';

	return {
		clone:         require('./array/clone'),
		first:         require('./array/first'),
		find:          require('./array/find'),
		findIndex:     require('./array/findIndex'),
		flatten:       require('./array/flatten'),
		get2D:         require('./array/get2D'),
		getDifference: require('./array/getDifference'),
		getRandom:     require('./array/getRandom'),
		has:           require('./array/has'),
		intersect:     require('./array/intersect'),
		last:          require('./array/last'),
		mapToObject:   require('./array/mapToObject'),
		nextIndex:     require('./array/nextIndex'),
		nextIndexTo:   require('./array/nextIndexTo'),
		nextTo:        require('./array/nextTo'),
		overlaps:      require('./array/overlaps'),
		prevIndex:     require('./array/prevIndex'),
		prevIndexTo:   require('./array/prevIndexTo'),
		prevTo:        require('./array/prevTo'),
		remove:        require('./array/remove'),
		set2D:         require('./array/set2D'),
		shuffle:       require('./array/shuffle'),
		subtract:      require('./array/subtract'),
	};

});
