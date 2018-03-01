
define( function (require) {
	'use strict';

	return {
		bindMethod: require('./object/bindMethod'),
		every:      require('./object/every'),
		filter:     require('./object/filter'),
		forEach:    require('./object/forEach'),
		isEmpty:    require('./object/isEmpty'),
		lateProp:   require('./object/lateProp'),
		map:        require('./object/map'),
		merge:      require('./object/merge'),
		mergeInto:  require('./object/mergeInto'),
		size:       require('./object/size'),
		some:       require('./object/some'),
		values:     require('./object/values'),
		valueToKey: require('./object/valueToKey'),
	};

});
