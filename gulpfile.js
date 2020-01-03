
const gulp = require('gulp');
const elm = require('gulp-elm');
const rename = require('gulp-rename');
const { promisify } = require('util');
const exec = promisify(require('child_process').exec);


const copy = () =>
	gulp.src('source/copy/**')
	.pipe(gulp.dest('build/'));

const formatElm = () =>
	exec('npx elm-format source/elm/ --yes');

const buildElm = () =>
	gulp.src('source/elm/Main.elm')
	.pipe(elm({ optimize: true }))
	.pipe(rename('main.js'))
	.pipe(gulp.dest('build/'));

const watchCopy = () =>
	gulp.watch('source/copy/**', copy);

const watchElm = () =>
	gulp.watch('source/elm/**/*.elm', gulp.series(formatElm, buildElm));

const build = gulp.parallel(copy, buildElm);

const watch = gulp.parallel(watchCopy, watchElm);


module.exports = {
	default: build,
	copy,
	formatElm,
	buildElm,
	build,
	watch,
};

