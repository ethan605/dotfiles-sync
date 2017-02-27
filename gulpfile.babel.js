// Gulp modules
import gulp from 'gulp';
import debug from 'gulp-debug';
// import file from 'gulp-file';
// import filenames from 'gulp-filenames';
// import through from 'through2';

// Helpers
import './gulp-helpers/backup';
import { wrapHomeDir } from './gulp-helpers/helpers';

gulp.task('exp', () => {
  const SUBLIME_PACKAGES_PATH = 'Library/Application Support/Sublime Text 3/Packages';
  const files = [
    wrapHomeDir(`${SUBLIME_PACKAGES_PATH}/*`),
    wrapHomeDir(`${SUBLIME_PACKAGES_PATH}/User`, { excluded: true }),
  ];

  gulp.src(files)
    .pipe(debug({ title: 'sublime' }));
});
