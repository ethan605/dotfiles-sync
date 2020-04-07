// Gulp modules
import gulp from 'gulp';

// Helpers
import { composeReadCommandTask } from '../helpers';
import type { ReadCommandTask } from '../helpers';

const TASKS: ReadCommandTask[] = [
  { title: 'nodeVersions', command: 'source $NVM_DIR/nvm.sh && nvm_ls | grep -E "^v"' },
  {
    title: 'globalNpmPackages',
    command: 'ls $(npm config get prefix)/lib/node_modules',
  },
];

export default gulp.parallel(TASKS.map(composeReadCommandTask('nvm')));
