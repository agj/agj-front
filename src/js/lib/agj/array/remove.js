
define( function (require) {
	'use strict';

	var toArray = require('../utils/toArray');
	var not = require('../function/not');
	var equals = require('../is').equal;
	// var value = require('../to').value;

	function remove(arr, item) {
		return arr.filter(not(equals(item)));
	}

	//function remove()

	return remove;
	
});
