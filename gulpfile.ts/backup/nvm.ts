import _ from 'lodash';

// Gulp modules
import gulp from 'gulp';
import file from 'gulp-file';

// Helpers
import { readCommandOutputs } from '../helpers';

// Constants
import { BACKUP_DIR } from '../constants';

const nvm = (): NodeJS.ReadWriteStream => {
  const nvmLs = readCommandOutputs('source $NVM_DIR/nvm.sh && nvm_ls').toString();
  const versions = _.compact(nvmLs.split('\n'));
  return file('versions.json', JSON.stringify(versions), { src: true }).pipe(gulp.dest(`${BACKUP_DIR}/nvm`));
};

export default nvm;
