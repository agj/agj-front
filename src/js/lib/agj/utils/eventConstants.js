
define( function (require) {
	"use strict";

	var module = require('../object/module');

	return module({}, {
		mouse: module({}, {
			click: "click",
			doubleClick: "dblclick",
			down: "mousedown",
			up: "mouseup",
			move: "mousemove",
			over: "mouseover",
			out: "mouseout",
			enter: "mouseenter",
			leave: "mouseleave",
			wheel: "wheel",
			contextMenu: "contextmenu",
			contextMenuShow: "show",
		}),
		key: module({}, {
			down: "keydown",
			up: "keyup",
			press: "keypress",
		}),
		composition: module({}, {
			start: "compositionstart",
			update: "compositionupdate",
			end: "compositionend",
		}),
		ui: module({}, {
			input: "input",
			change: "change",
			focus: "focus",
			blur: "blur",
			focusIn: "focusin",
			focusOut: "focusout",
			invalid: "invalid",
			reset: "reset",
			submit: "submit",
			select: "select",
			viewResize: "resize",
			scroll: "scroll",
			hashChange: "hashchange",
		}),
		motion: module({}, {
			orientationChange: "orientationchange",
			gyroscope: "deviceorientation",
			accelerometer: "devicemotion",
		}),
		load: module({}, {
			readyStateChange: "readystatechange",
			load: "load",
			unload: "unload",
			abort: "abort",
			error: "error",
		}),
		touch: module({}, {
			start: "touchstart",
			end: "touchend",
			move: "touchmove",
			cancel: "touchcancel",
			enter: "touchenter",
			leave: "touchleave",
		}),
	});

});
