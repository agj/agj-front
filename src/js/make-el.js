
const anyEl (tag) => {
	const id      = setElseDo(tag.match(/#([^\.\s]+)/),  null, processID);
	const classes = setElseDo(tag.match(/\.[^\.\s#]+/g), null, processClasses);
	tag           = setElseDo(tag.match(/^([^\.\s#]+)/), null, processTag);
	if (tag === null) throw "No tag specified.";

	const element = document.createElement(tag);
	if (id !== null) element.id = id;
	if (classes !== null) element.className = classes.join(' ');
	return element;
}

