
define(function(require) {
	'use strict';

	var $ = require('jquery');
	var bacon = require('bacon');
	var defineModules = require('../utils/defineModules');
	var is = require('../is');
	var to = require('../to');
	var events = require('../utils/eventConstants');

	var module = defineModules({}, {
		keyIsPressed: function (key) {
			return bacon.fromEventTarget($(window), events.key.down).map('.which').filter(is.equal(key)).map(to.value(true))
				.merge(bacon.fromEventTarget($(window), events.key.up).map('.which').filter(is.equal(key)).map(to.value(false)))
				.toProperty(false);
		}
	});

	return module;

});
