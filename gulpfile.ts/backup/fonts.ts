import gulp from 'gulp';

// Helpers
import { composeZipTask, wrapHomeDir } from '../helpers';
import type { ZipConfig } from '../helpers';

const SOURCES: ZipConfig[] = [
  {
    title: 'operatorMonoLig',
    path: wrapHomeDir('Library/Fonts/OperatorMonoLig-*'),
  },
];

export default gulp.parallel(SOURCES.map(composeZipTask('fonts')));
