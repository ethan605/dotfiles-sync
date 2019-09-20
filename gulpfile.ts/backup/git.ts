// Gulp modules
import gulp from 'gulp';

// Helpers
import { wrapHomeDir } from '../helpers';

// Constants
import { BACKUP_DIR } from '../constants';

const git = (): NodeJS.ReadWriteStream => {
  return gulp.src(wrapHomeDir('.gitconfig')).pipe(gulp.dest(`${BACKUP_DIR}/git`));
};

export default git;
