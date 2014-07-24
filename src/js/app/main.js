
define( function(require) {

	var $ = require('jquery');
	var makeDOM = require('agj/domGenerator/inject');
	var sequence = require('agj/function/sequence');
	var promoteArg = require('agj/function/promoteArg');
	var prop = require('agj/to').prop;
	var equals = require('agj/is').equal;
	var log = require('agj/utils/log');
	var toArray = require('agj/utils/toArray');
	var randomInt = require('agj/random/integer');
	var inArray = require('agj/array/has');

	var cfg = {
		letterSwapInterval: 1100,
	};

	$(document).ready( function () {
		var main = $('#main');

		getTextNodes(main)
			.forEach( function (tn) {
				$(tn).replaceWith(putLettersIntoSpans(tn));
			});
		letterNodes = main.find('span.char').toArray();
		swappableLetterNodes = main.find('span.char.swap').toArray();
		processLetterNodes(letterNodes); // Adds zero-width spaces after each character, so words may wrap at any position.
		updateLineBreaks(); // Finds where the text breaks, so as later not to make changes to the text that would alter its flow on the page.
		
		setInterval( function () {
			swapLetterPair();
		}, cfg.letterSwapInterval);
		
		window.addEventListener('resize', function () {
			if (!lineBreaksDirty) {
				lineBreaksDirty = true;
				removeHardBreaks();
			}
		});
	});


	/////

	var letterNodes;
	var swappableLetterNodes;
	var lineBreaks;
	var lineBreaksDirty;
	var swapTurn = 0;

	/////
	
	function getTextNodes(parent) {
		var results = [];
		$(parent).contents()
			.each( function (i, node) {
				if (node.nodeType === node.TEXT_NODE) results.push(node);
				else results = results.concat(getTextNodes(node));
			});
		return results;
	}

	function processLetterNodes(letterNodes) {
		$(letterNodes).append('&#8203;<wbr/>');
	}
	
	function updateLineBreaks() {
		lineBreaks = [];
		var prevYPos = $(letterNodes[0]).position().top;
		var i = 0, len = letterNodes.length;
		while (++i < len) {
			var currYPos = $(letterNodes[i]).position().top;
			if (prevYPos !== currYPos) {
				lineBreaks.push(i);
				prevYPos = currYPos;
			}
		}
		addHardBreaks();
		lineBreaksDirty = false;
	}
	
	/////
	
	function putLettersIntoSpans(textNode) {
		var text = fixWhitespace(textNode.data);
		return makeDOM( function (span) {
			var chars = [];
			var i = -1, len = text.length;
			while (++i < len) {
				var char = text.charAt(i);
				chars.push(span(isSwappableChar(char) ? '.char.swap' : '.char', text.charAt(i)));
			}
			return span.apply(null, chars);
		});
	}
	
	function swapLetterPair() {
		if (lineBreaksDirty)
			updateLineBreaks();
		
		var pos = randomInt(swappableLetterNodes.length - 1);
		while (isCharBeforeBreak(swappableLetterNodes[pos])) {
			pos = (pos + 1) % (swappableLetterNodes.length - 1);
		}
		
		var nodeA = $(swappableLetterNodes[pos]);
		var nodeB = $(swappableLetterNodes[pos + 1]);
		
		var temp = nodeA.html();
		nodeA.html(nodeB.html());
		nodeB.html(temp);

		nodeA.addClass('swapped turn' + (swapTurn % 4 + 1));
		nodeB.addClass('swapped turn' + (swapTurn % 4 + 1));
		swapTurn++;
	}
	
	function addHardBreaks() {
		var i = -1, len = lineBreaks.length;
		while (++i < len - 1) {
			var current = letterNodes[lineBreaks[i]];
			if (current.parentNode.parentNode.id !== 'about') { // This avoids putting a br tag before the smaller text block.
				$(current).before('<br class="break" />');
			}
		}
	}
	
	function removeHardBreaks() {
		$('#main br.break').remove();
	}
	
	function fixWhitespace(text) {
		if (!text) return "";
		return text.replace(/\s+/g, " ");
	}
	
	function isSwappableChar(letter) {
		return (letter.search(/\w/) === 0);
	}

	function isCharBeforeBreak(letterNode) {
		var pos = letterNodes.indexOf(letterNode);
		var nextPos = pos;
		var lnLen = letterNodes.length;
		while (++nextPos < lnLen) {
			if (inArray(lineBreaks, nextPos)) return true;
			if (inArray(swappableLetterNodes, letterNodes[nextPos])) return false;
		}
		return true;
	}

});
