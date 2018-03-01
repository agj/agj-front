
define( function (require) {

	function boolean(probability) {
		if (isNaN(probability))
			probability = 0.5;
		return Math.random() < probability;
	}

	return boolean;

});
