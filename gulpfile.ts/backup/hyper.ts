// Gulp modules
import gulp from 'gulp';

// Helpers
import { wrapHomeDir } from '../helpers';

// Constants
import { BACKUP_DIR } from './constants';

const hyper = (): NodeJS.ReadWriteStream => {
  return gulp.src(wrapHomeDir('.hyper.js')).pipe(gulp.dest(`${BACKUP_DIR}/hyper`));
};

export default hyper;
