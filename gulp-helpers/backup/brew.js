// Gulp modules
import gulp from 'gulp';
import file from 'gulp-file';

// Helpers
import { readCommandOutputs } from '../helpers';

// Constants
import { BACKUP_DIR } from '../constants';

gulp.task('backup:brew', () => {
  const packages = readCommandOutputs('brew list --versions').toString();

  return gulp.src('!dotfiles')
    .pipe(file('packages', packages))
    .pipe(gulp.dest(`${BACKUP_DIR}/brew`));
});
