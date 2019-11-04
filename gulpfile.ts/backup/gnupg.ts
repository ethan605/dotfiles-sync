// Gulp modules
import gulp from 'gulp';

// Helpers
import { wrapHomeDir } from '../helpers';

// Constants
import { BACKUP_DIR } from '../constants';

const gnupg = (): NodeJS.ReadWriteStream =>
  gulp.src(wrapHomeDir('.gnupg/*.conf')).pipe(gulp.dest(`${BACKUP_DIR}/gnupg`));

export default gnupg;
