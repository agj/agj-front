
const gulp = require('gulp');
const elm = require('gulp-elm');
const rename = require('gulp-rename');


const copy = () =>
	gulp.src('source/copy/**')
	.pipe(gulp.dest('build/'));

const watchCopy = () =>
	gulp.watch('source/copy/**', copy);

const buildElm = () =>
	gulp.src('source/elm/Main.elm')
	.pipe(elm({ optimize: true }))
	.pipe(rename('main.js'))
	.pipe(gulp.dest('build/'));

const watchBuildElm = () =>
	gulp.watch('source/elm/**/*.elm', buildElm);

const build = gulp.parallel(copy, buildElm);

const watch = gulp.parallel(watchCopy, watchBuildElm);


module.exports = {
	default: build,
	copy,
	buildElm,
	build,
	watch,
};

