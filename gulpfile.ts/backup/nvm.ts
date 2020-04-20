// Gulp modules
import gulp from 'gulp';

// Helpers
import { composeReadCommandTask } from '../helpers';
import type { ReadCommandConfig } from '../helpers';

const TASKS: ReadCommandConfig[] = [
  { title: 'nodeVersions', command: 'PREFIX="" source $NVM_DIR/nvm.sh && nvm_ls | grep -E "^v"' },
  {
    title: 'globalNpmPackages',
    command: '/bin/ls $(npm config get prefix)/lib/node_modules',
  },
];

export default gulp.parallel(TASKS.map(composeReadCommandTask('nvm')));
