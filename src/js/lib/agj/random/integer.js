
define( function (require) {

	function integer(from, to) {
		if (to === undefined) {
			return Math.floor(Math.random() * from);
		}
		else return Math.floor(Math.random() * (to - from) + from);
	}

	return integer;

});
