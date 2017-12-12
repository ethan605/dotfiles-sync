// Gulp modules
import gulp from 'gulp';

// Helpers
import { wrapHomeDir } from '../helpers';

// Constants
import { BACKUP_DIR } from '../constants';

gulp.task('backup:hyper', () => {
  gulp.src(wrapHomeDir('.hyper.js'))
    .pipe(gulp.dest(`${BACKUP_DIR}/hyper`));
});
