// Gulp modules
const gulp = require('gulp');
const clean = require('gulp-clean');
const sequence = require('gulp-sequence');
// const shell = require('gulp-shell');

const DEST_DIR = './files';

const wrapHomeDir = filename => `${process.env.HOME}/${filename}`;

gulp.task('backup:clean', () => gulp.src(DEST_DIR).pipe(clean()));

gulp.task('backup:oh-my-zsh', () => {
  const fileNames = [
    '.zshrc',
    '.oh-my-zsh/custom/**/*',
  ].map(wrapHomeDir);

  gulp.src(fileNames).pipe(gulp.dest(`${DEST_DIR}/oh-my-zsh`));
});

gulp.task('backup', sequence(
  'backup:clean',
  'backup:oh-my-zsh'
));
