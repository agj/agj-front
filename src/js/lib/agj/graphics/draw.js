
/**
 * Utilities for drawing on a canvas object.
 *
 * Created by agj (www.agj.cl).
 */

define( function (require) {
	'use strict';

	var parseRGB = require('../color/parseRGB');
	var toHex = require('../number/inBase')(16);
	var variadic = require('../function/variadic');
	var autoCurry = require('../function/autoCurry');
	var first = require('../array/first');
	var last = require('../array/last');

	var draw = {
		line: autoCurry(function (context2D, drawStyle, from, to) {
			if ((from.x !== to.x) || (from.y !== to.y)) {
				context2D.save();
				context2D.beginPath();
				setLine(context2D, drawStyle);
				context2D.moveTo(from.x, from.y);
				context2D.lineTo(to.x, to.y);
				endLine(context2D, drawStyle);
				context2D.restore();
			} else {
				drawPoint(context2D, drawStyle, from, to);
			}
		}),

		curve: autoCurry(3, variadic(function (context2D, drawStyle, points) {
			var from = first(points);
			var to = last(points);
			if ((from.x !== to.x) || (from.y !== to.y)) {
				context2D.save();
				context2D.beginPath();
				setLine(context2D, drawStyle);
				context2D.moveTo(from.x, from.y);
				if (points.length === 3)      context2D.quadraticCurveTo(points[1].x, points[1].y, to.x, to.y);
				else if (points.length === 4) context2D.bezierCurveTo(points[1].x, points[1].y, points[2].x, points[2].y, to.x, to.y);
				else throw new Error("Wrong number of points passed.");
				endLine(context2D, drawStyle);
				context2D.restore();
			} else {
				drawPoint(context2D, drawStyle, from, to);
			}
		})),

		circle: autoCurry(function (context2D, drawStyle, circ) {
			context2D.save();
			context2D.beginPath();
			setLine(context2D, drawStyle);
			setFill(context2D, drawStyle);
			context2D.arc(circ.x, circ.y, circ.radius, 0, Math.PI * 2);
			endFill(context2D, drawStyle);
			endLine(context2D, drawStyle);
			context2D.restore();
		}),

		rectangle: autoCurry(function (context2D, drawStyle, rect) {
			context2D.save();
			context2D.beginPath();
			setFill(context2D, drawStyle);
			context2D.fillRect(rect.x, rect.y, rect.width, rect.height);
			endFill(context2D, drawStyle);
			context2D.restore();
		})
	};

	function setLine(context2D, drawStyle) {
		if (drawStyle.definesLine()) {
			var c = parseRGB(drawStyle.lineColor());
			context2D.lineWidth = drawStyle.lineWeight();
			context2D.strokeStyle = 'rgba(' + c.red + ',' + c.green + ',' + c.blue + ',' + drawStyle.lineAlpha() + ')';
			context2D.lineCap = drawStyle.lineCapsStyle();
		}
	}
	function setFill(context2D, drawStyle) {
		if (drawStyle.definesFill()) {
			var c = parseRGB(drawStyle.lineColor());
			context2D.fillStyle = 'rgba(' + c.red + ',' + c.green + ',' + c.blue + ',' + drawStyle.fillAlpha() + ')';
		}
	}
	function endLine(context2D, drawStyle) {
		if (drawStyle.definesLine()) {
			context2D.stroke();
		}
	}
	function endFill(context2D, drawStyle) {
		if (drawStyle.definesFill()) {
			context2D.fill();
		}
	}

	function drawPoint(context2D, drawStyle, from, to) {
		if (drawStyle.lineCapsStyle() === 'round') {
			draw.circle(context2D, drawStyle, { x: from.x, y: from.y, radius: drawStyle.lineWeight() * 0.5 });
		} else {
			var halfLT = drawStyle.lineWeight() / 2;
			draw.rectangle(context2D, drawStyle, { x: from.x - halfLT, y: from.y - halfLT, width: drawStyle.lineWeight(), height: drawStyle.lineWeight() });
		}
	}

	return draw;

});

