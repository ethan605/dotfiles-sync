'use strict';

// Gulp modules
import gulp from 'gulp';
import clean from 'gulp-clean';
import sequence from 'gulp-sequence';
import shell from 'gulp-shell';

const DEST_DIR = './files';

gulp.task('backup:clean', () => gulp.src(DEST_DIR).pipe(clean()));

gulp.task('backup:oh-my-zsh', () => (
  gulp.src(['~/.zshrc', '~/.oh-my-zsh/custom'])
    .pipe(gulp.dest(`${DEST_DIR}/oh-my-zsh`))
));

gulp.task('backup', sequence(
  'backup:clean',
  'backup:oh-my-zsh',
));
