
define( function (require) {
	'use strict';

	var defineModules = require('./utils/defineModules');

	return defineModules({}, {
		TAU: Math.PI * 2,

		cartesianToRadians: function (x, y) {
			return Math.atan2(y, x);
		},

		curve: function (numberValue, numberGentleness, numberPeak, numberValueSubtract) {
			if (numberValueSubtract)
				numberValue = Math.max(numberValue - numberValueSubtract, 0);
			if (numberGentleness < 1)
				numberGentleness = 1;
			return numberPeak / ((numberValue / numberGentleness) + 1);
		},
	});

});
