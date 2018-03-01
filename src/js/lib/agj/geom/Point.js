
define( function (require) {
	'use strict';

	var Class = require('../class/Class');

	var Point = Class.extend({
		init: function (x, y) {
			this.set(x, y);
		},

		set: function (x, y) { // self
			this.x = isNaN(x) ? 0 : x;
			this.y = isNaN(y) ? 0 : y;
			return this;
		},

		add: function (point) { // self
			this.x += point.x;
			this.y += point.y;
			return this;
		},

		subtract: function (point) { // self
			this.x -= point.x;
			this.y -= point.y;
			return this;
		},

		scale: function (value) { // self
			this.x *= value;
			this.y *= value;
			return this;
		},

		rotate: function (radians) { // self
			if (isNaN(radians) || radians === 0)
				return this;
			var angle = Math.cartesianToRadians(this.x, this.y);
			angle += radians;
			var length = this.getLength();
			this.set(
				length * Math.cos(angle),
				length * Math.sin(angle)
			);
			return this;
		},

		clone: function () { // Point
			return new module.Point(this.x, this.y);
		},

		copy: function (point) { // self
			return this.set(point.x, point.y);
		},

		getLength: function () { // Number
			return Math.sqrt(this.x * this.x + this.y * this.y);
		},

		toRadians: function () { // Number
			return Math.cartesianToRadians(this.x, this.y);
		},

		toString: function () {
			return '(' + this.x + ',' + this.y + ')';
		},

		statics: {
			getDistance: function (point1, point2) { // Number
				var x = point1.x - point2.x;
				var y = point1.y - point2.y;
				return Math.sqrt(x * x + y * y);
			},

			interpolate: function (point1, point2, position) { // Point
				var x = point2.x - point1.x;
				var y = point2.y - point1.y;
				return new module.Point(
					x * position + point1.x,
					y * position + point1.y
				);
			},

			fromPolar: function (radians, length) { // Point
				if (isNaN(length))
					length = 1;
				return new module.Point(
					length * Math.cos(radians),
					length * Math.sin(radians)
				);
			},

			fromObject: function (obj) { // Point
				return new module.Point(obj.x, obj.y);
			}
		}
	});

	return Point;

});