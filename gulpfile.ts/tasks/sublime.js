// Gulp modules
import gulp from 'gulp';
import file from 'gulp-file';

// Helpers
import fs from 'fs';
import _ from 'lodash';
import { wrapHomeDir } from '../helpers';

// Constants
import { BACKUP_DIR } from '../constants';

const SUBLIME_PACKAGES_PATH = 'Library/Application Support/Sublime Text 3/Packages';
const SUBLIME_SETTINGS_PATH = `${SUBLIME_PACKAGES_PATH}/User/Preferences.sublime-settings`;

gulp.task('backup:sublime', () => {
  const packages = fs.readdirSync(wrapHomeDir(SUBLIME_PACKAGES_PATH));
  _.remove(packages, filename => (filename === '.DS_Store' || filename === 'User'));

  return gulp.src(wrapHomeDir(SUBLIME_SETTINGS_PATH))
    .pipe(file('packages', packages.join('\n')))
    .pipe(gulp.dest(`${BACKUP_DIR}/sublime`));
});
