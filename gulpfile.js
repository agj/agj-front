
import gulp from 'gulp'
import elm from 'gulp-elm'
import rename from 'gulp-rename'
import { promisify } from 'util';
import { exec as execOriginal } from 'child_process';

const exec = promisify(execOriginal);

export const copy = () =>
	gulp.src('source/copy/**')
	.pipe(gulp.dest('build/'));

export const formatElm = () =>
	exec('npx elm-format source/elm/ --yes');

export const buildElm = () =>
	gulp.src('source/elm/Main.elm')
	.pipe(elm({ optimize: true }))
	.pipe(rename('main.js'))
	.pipe(gulp.dest('build/'));

const watchCopy = () =>
	gulp.watch('source/copy/**', copy);

const watchElm = () =>
	gulp.watch('source/elm/**/*.elm', gulp.series(formatElm, buildElm));

export const build = gulp.parallel(copy, buildElm);

export const watch = gulp.parallel(watchCopy, watchElm);

export default build;
