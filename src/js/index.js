
import R from 'ramda';
import D from './dom';
import flyd from 'flyd';
import every from 'flyd/module/every';
import filter from 'flyd/module/filter';
import { install } from 'dot-into';
install();

const counter = () => { let i = 0; return () => i++ };


D.loaded()
.then(() => {
	var el = D.sel('.test');

	console.log(el);

	const time =
		every(250)
		.into(R.map(counter()))
		.into(R.map(R.add(1)))
		.into(R.map(R.take(R.__, 'something or other')));

	time
	.into(filter(R.equals('something or other')))
	.into(flyd.on(time.end));

	time
	.into(flyd.on(text => {
		D.setContent(text, el);
		console.log(text);
	}));

});
