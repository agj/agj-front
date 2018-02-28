
const R = require('ramda');

const getTag = R.when(R.match(/^([^\.\s#]+)/), R.prop(1));
const getID = R.when(R.match(/#([^\.\s#]+)/), R.prop(1));
const getClasses = R.when(R.match(/\.[^\.\s#]+/g), R.map(str => str.substr(1)));

const dom = {
	loaded: () => new Promise((done, error) =>
		/interactive|complete/.test(document.readyState)
		? done(true)
		: document.addEventListener('DOMContentLoaded', done)),
	create: R.curry((desc, attrs, ...children) => {
		const tag = getTag(desc);
		const id = getID(desc);
		const classes = getClasses(desc);
		const element = document.createElement(tag);
		if (id != null) element.id = id;
		if (classes != null) element.className = classes.join(' ');
		if (attrs) Object.keys(attrs).forEach(attr => el.setAttribute(attr, attrs[attr]));
		children.map(obj => R.is(String, obj) ? dom.text(obj) : obj)
			.forEach(node => el.appendChild(node));
		return element;
	}),
	append: R.curry((child, parent) => parent.appendChild(dom.forceNode(child))),
	prepend: R.curry((child, parent) => parent.insertBefore(dom.forceNode(child), parent.firstChild)),
	sel: selector => document.querySelector(selector),
	selAll: selector => Array.from(document.querySelectorAll(selector)),
	selIn: R.curry((parent, selector) => parent.querySelector(selector)),
	selAllIn: R.curry((parent, selector) => Array.from(parent.querySelectorAll(selector))),
	setContent: R.curry((content, parent) => { dom.empty(parent); dom.append(content, parent) }),
	text: document.createTextNode.bind(document),
	setAttr: R.curry((value, name, el) => el.setAttribute(name, value)),
	empty: el => Array.from(el.childNodes).forEach(child => el.removeChild(child)),
	forceNode: obj => R.is(String, obj) ? dom.text(obj) : obj,
};

module.exports = dom;
