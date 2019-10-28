// Gulp modules
import gulp from 'gulp';

// Helpers
import { wrapHomeDir } from '../helpers';

// Constants
import { BACKUP_DIR } from '../constants';

const vim = (): NodeJS.ReadWriteStream => {
  return gulp.src(wrapHomeDir('.vimrc')).pipe(gulp.dest(`${BACKUP_DIR}/vim`));
};

export default vim;
