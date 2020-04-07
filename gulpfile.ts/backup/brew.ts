import _ from 'lodash';

// Gulp modules
import gulp from 'gulp';
import file from 'gulp-file';

// Helpers
import { readCommandOutputs } from '../helpers';

// Constants
import { BACKUP_DIR } from '../constants';

const brew = (): NodeJS.ReadWriteStream => {
  const output = readCommandOutputs('brew list').toString();
  const packages = _.compact(output.split('\n'));
  return file('packages.json', JSON.stringify(packages), { src: true }).pipe(gulp.dest(`${BACKUP_DIR}/brew`));
};

gulp.task('brew', brew);
export default brew;
