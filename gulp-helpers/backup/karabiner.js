// Gulp modules
import gulp from 'gulp';

// Helpers
import { wrapHomeDir } from '../helpers';

// Constants
import { BACKUP_DIR } from '../constants';

gulp.task('backup:karabiner', () => {
  gulp.src(wrapHomeDir('.config/karabiner/**/*.json'))
    .pipe(gulp.dest(`${BACKUP_DIR}/karabiner`));
});
