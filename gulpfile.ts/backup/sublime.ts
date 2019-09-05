import fs from 'fs';
import _ from 'lodash';
import gulp from 'gulp';
import file from 'gulp-file';

// Constants
import { BACKUP_DIR } from './constants';

// Helpers
import { wrapHomeDir } from '../helpers';

const SUBLIME_PACKAGES_PATH = 'Library/Application Support/Sublime Text 3/Packages';
const SUBLIME_SETTINGS_PATH = `${SUBLIME_PACKAGES_PATH}/User/Preferences.sublime-settings`;

const sublime = (callback: Function): NodeJS.ReadWriteStream => {
  try {
    const allPackages = fs.readdirSync(wrapHomeDir(SUBLIME_PACKAGES_PATH));
    const packages = _.reject(allPackages, filename => filename === '.DS_Store' || filename === 'User');

    return gulp
      .src(wrapHomeDir(SUBLIME_SETTINGS_PATH))
      .pipe(file('packages', packages.join('\n')))
      .pipe(gulp.dest(`${BACKUP_DIR}/sublime`));
  } catch (error) {
    callback();
  }
};

export default sublime;
