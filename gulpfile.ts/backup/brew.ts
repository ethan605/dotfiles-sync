// Gulp modules
import gulp from 'gulp';
import file from 'gulp-file';

// Helpers
import { readCommandOutputs } from '../helpers';

// Constants
import { BACKUP_DIR } from './constants';

const brew = (callback: Function): void => {
  const packages = readCommandOutputs('brew list --versions').toString();
  file('packages', packages).pipe(gulp.dest(`${BACKUP_DIR}/brew`));
  callback();
};

export default brew;
