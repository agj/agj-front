
define( function (require) {
	'use strict';

	var Class = require('../class/Class');

	var Rectangle = Class.extend({
		init: function (x, y, width, height) {
			this.set(x, y, width, height);
		},

		set: function (x, y, width, height) { // self
			this.x = isNaN(x) ? 0 : x;
			this.y = isNaN(y) ? 0 : y;
			this.width = isNaN(width) ? 0 : width;
			this.height = isNaN(height) ? 0 : height;
			return this;
		},

		clone: function () { // Rectangle
			return new module.Rectangle(this.x, this.y, this.width, this.height);
		},

		grow: function (wide, high) { // self
			var w = wide * 0.5;
			var h = high * 0.5;
			this.x -= w;
			this.y -= h;
			this.width += w;
			this.height += h;
			return this;
		},

		getTop: function () { // Number
			return Math.min(this.y, this.height + this.y);
		},
		getRight: function () { // Number
			return Math.max(this.x + this.width, this.x);
		},
		getBottom: function () { // Number
			return Math.max(this.y + this.height, this.y);
		},
		getLeft: function () { // Number
			return Math.min(this.x, this.width + this.x);
		},

		getArea: function () { // Number
			return Math.abs(this.width * this.height);
		},

		intersects: function (rect) { // Boolean
			var thisL = this.getLeft();
			var rectL = rect.getLeft();
			var thisR = this.getRight();
			var rectR = this.getRight();
			var left = Math.max(thisL, rectL);
			var right = Math.min(thisR, rectR);
			if (left >= right)
				return false;

			var thisT = this.getTop();
			var rectT = rect.getTop();
			var thisB = this.getBottom();
			var rectB = rect.getBottom();
			var top = Math.max(thisT, rectT);
			var bottom = Math.min(thisB, rectB);
			return top < bottom;
		},

		contains: function (rectOrPoint) { // Boolean
			if (rectOrPoint.width) {
				return this.getTop() <= rectOrPoint.getTop() &&
				       this.getRight() >= rectOrPoint.getRight() &&
				       this.getBottom() >= rectOrPoint.getBottom &&
				       this.getLeft() <= rectOrPoint.getLeft();
			} else {
				return this.getTop() <= rectOrPoint.y &&
				       this.getRight() >= rectOrPoint.x &&
				       this.getBottom() >= rectOrPoint.y &&
				       this.getLeft() <= rectOrPoint.x;
			}
		},

		excludes: function (rect) { // Boolean
			return this.getTop() >= rect.getBottom() ||
				this.getRight() <= rect.getLeft() ||
				this.getBottom() <= rect.getTop() ||
				this.getLeft() >= rect.getRight();
		},

		toString: function () {
			return '(x:' + this.x + ',y:' + this.y + ',w:' + this.width + ',h:' + this.height + ')';
		}
	});

	return Rectangle;

});
