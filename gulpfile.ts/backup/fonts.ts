import gulp from 'gulp';

// Helpers
import { composeZipTask, wrapHomeDir } from '../helpers';
import type { ZipConfig } from '../helpers';

const ZIP_SOURCES: ZipConfig[] = [
  {
    path: wrapHomeDir('Library/Fonts/OperatorMonoLig-*'),
    title: 'operatorMonoLig',
  },
];

export default gulp.parallel(ZIP_SOURCES.map(composeZipTask('fonts')));
