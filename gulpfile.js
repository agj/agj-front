
// Requires.

const gulp = require('gulp');
const browserify = require('browserify');
const watchify = require('watchify');
const babelify = require('babelify');
const source = require('vinyl-source-stream');
const R = require('ramda');
const argv = require('yargs').argv;
const gutil = require('gulp-util');
const uglify = require('gulp-uglify');
const es = require('event-stream');
const buffer = require('vinyl-buffer');
const rename = require('gulp-rename');
require('dot-into').install();


// Options.

const browserifyOpts = {
	entries: 'src/js/index.js',
	debug: true,
};


// Preparation.

const watch = !!argv.watch;

const getBrowserify = opts =>
	browserify(opts)
	.transform('babelify', { presets: 'es2015' });
const b = !watch
	? getBrowserify(browserifyOpts)
	: watchify(getBrowserify(R.merge(watchify.args, browserifyOpts)));
const bundle = () =>
	b.bundle()
	.on('error', gutil.log.bind(gutil, "Browserify error."))
	.pipe(source('script.js'))
	// .pipe(buffer()).pipe(uglify())
	.pipe(gulp.dest('dist/js/'));

if (watch) {
	b.on('update', bundle);
	gulp.watch('src/**/*.css', ['copy']);
}
b.on('log', gutil.log);


// Tasks.

gulp.task('default', ['browserify', 'copy']);
gulp.task('browserify', bundle);
gulp.task('copy', () =>
	gulp.src('src/**/*.{html,css}')
	.pipe(gulp.dest('dist/')));

