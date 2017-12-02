// Gulp modules
import gulp from 'gulp';
import file from 'gulp-file';

// Helpers
import fs from 'fs';
import _ from 'lodash';
import { wrapHomeDir } from '../helpers';

// Constants
import { BACKUP_DIR, SUBLIME_PACKAGES_PATH, SUBLIME_SETTINGS_PATH } from '../constants';

gulp.task('backup:sublime', () => {
  const packages = fs.readdirSync(wrapHomeDir(SUBLIME_PACKAGES_PATH));
  _.remove(packages, filename => (filename === '.DS_Store' || filename === 'User'));

  return gulp.src(wrapHomeDir(SUBLIME_SETTINGS_PATH))
    .pipe(file('packages', packages.join('\n')))
    .pipe(gulp.dest(`${BACKUP_DIR}/sublime`));
});
