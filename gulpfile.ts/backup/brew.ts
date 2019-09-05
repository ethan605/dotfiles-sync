// Gulp modules
import gulp from 'gulp';
import file from 'gulp-file';

// Helpers
import { readCommandOutputs } from '../helpers';

// Constants
import { BACKUP_DIR } from '../constants';

const brew = (): NodeJS.ReadWriteStream => {
  const packages = readCommandOutputs('brew list --versions').toString();
  return file('packages', packages, { src: true }).pipe(gulp.dest(`${BACKUP_DIR}/brew`));
};

export default brew;
