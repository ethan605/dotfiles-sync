// Gulp modules
import gulp from 'gulp';

// Helpers
import { wrapHomeDir } from '../helpers';

// Constants
import { BACKUP_DIR } from '../constants';

const gnupg = (): NodeJS.ReadWriteStream => {
  return gulp.src(wrapHomeDir('.gnupg/*.conf')).pipe(gulp.dest(`${BACKUP_DIR}/gpgnu`));
};

export default gnupg;
