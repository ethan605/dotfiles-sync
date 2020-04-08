// Gulp modules
import gulp from 'gulp';

// Helpers
import { composeReadCommandTask } from '../helpers';
import type { ReadCommandConfig } from '../helpers';

const TASKS: ReadCommandConfig[] = [
  { title: 'formulaes', command: 'brew list' },
  { title: 'casks', command: 'brew cask list' },
  { title: 'taps', command: 'brew tap' },
];

export default gulp.parallel(TASKS.map(composeReadCommandTask('brew')));
