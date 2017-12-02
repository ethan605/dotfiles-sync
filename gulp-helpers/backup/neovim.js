// Gulp modules
import gulp from 'gulp';

// Helpers
import { wrapHomeDir } from '../helpers';

// Constants
import { BACKUP_DIR } from '../constants';

gulp.task('backup:neovim', () => (
  gulp.src(wrapHomeDir('.config/nvim/init.vim'))
    .pipe(gulp.dest(`${BACKUP_DIR}/neovim`))
));
