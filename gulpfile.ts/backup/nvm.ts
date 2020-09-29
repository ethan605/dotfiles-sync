// Gulp modules
import gulp from 'gulp';

// Helpers
import { composeReadCommandTask } from '../helpers';
import type { ReadCommandConfig } from '../helpers';

const TASKS: ReadCommandConfig[] = [
  {
    title: 'nodeVersions',
    command: '/bin/ls /usr/local/opt/nvm/versions/node',
  },
  {
    title: 'globalNpmPackages',
    command: '/bin/ls $(npm config get prefix)/lib/node_modules',
  },
];

export default gulp.parallel(TASKS.map(composeReadCommandTask('nvm')));
