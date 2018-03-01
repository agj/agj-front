
define( function (require) {
	'use strict';

	var Class = require('../class/Class');
	var returnThis = require('../function/returnThis');
	var passThis = require('../function/passThis');
	var overload = require('../function/overload');
	var sequence = require('../function/sequence');
	var maybe = require('../function/maybe');
	var not = require('../function/not');
	var partial = require('../function/partial');
	var within = require('../array/within');
	var to = require('../to');
	var is = require('../is');
	var toArray = require('../utils/toArray');

	var lineCapsStyles = ['butt', 'round', 'square'];
	var lineJointStyles = ['round', 'miter', 'bevel'];

	function checkColor(value) {
		return value & 0xffffff;
	}
	function checkNegative(elseValue) {
		return maybe(not(isNaN), elseValue, partial(Math.max, [0]));
	}
	function checkFraction(defaultValue) {
		return function (number) {
			if (isNaN(number))
				return defaultValue;
			return Math.max(0, Math.min(1, number));
		};
	}
	function checkAmong(allowed) {
		return maybe(within(allowed), allowed[0], to.id);
	}

	function doGetset(prop, getChecker, setChecker) {
		return function (value) {
			if (arguments.length) {
				this[prop] = setChecker(value);
				return this;
			} else {
				return getChecker(this[prop]);
			}
		};
	}
	var getset = overload(
		[[is.string, is.fn], function (prop, getChecker) {
			return doGetset(prop, getChecker, to.id);
		}],
		[[is.string, is.fn, is.fn], doGetset],
		[[is.string], function (prop) {
			return doGetset(prop, to.id, to.id);
		}]
	);
	
	var DrawStyle = Class.extend({
		fillColor:      getset('_fillColor',      checkColor),
		fillAlpha:      getset('_fillAlpha',      checkFraction(0)),
		lineColor:      getset('_lineColor',      checkColor),
		lineAlpha:      getset('_lineAlpha',      checkFraction(0)),
		lineWeight:     getset('_lineWeight',     checkNegative(0)),
		lineCapsStyle:  getset('_lineCapsStyle',  checkAmong(lineCapsStyles)),
		lineJointStyle: getset('_lineJointStyle', checkAmong(lineJointStyles)),
		lineMiterLimit: getset('_lineMiterLimit', checkNegative(3)),

		definesFill: function () { // Boolean
			return (this.fillAlpha() > 0);
		},
		definesLine: function () { // Boolean
			return (this.lineAlpha() > 0 && this.lineWeight() > 0);
		},
	});

	return DrawStyle;

});

