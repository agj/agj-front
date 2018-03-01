/**
 * Warning! This code modifies the prototypes of certain global objects.
 * Some are just polyfills, others are extensions.
 */

define(["../agj"], function (agj) {
	"use strict";

	var module = {};

	// ARRAY.SORT

	defineModule(module, "array.sort.descending", function (a, b) {
		return b - a;
	});


	return module;

});

