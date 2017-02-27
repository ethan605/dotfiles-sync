// Gulp modules
import gulp from 'gulp';
import debug from 'gulp-debug';

// Helpers
import './gulp-helpers/backup';
import { wrapHomeDir } from './gulp-helpers/helpers';

gulp.task('exp', () => {
  gulp.src(wrapHomeDir('.zshrc'))
    .pipe(debug({ title: 'zsh' }));
});
