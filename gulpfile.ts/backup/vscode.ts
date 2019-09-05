// Gulp modules
import gulp from 'gulp';
import file from 'gulp-file';

// Helpers
import { readCommandOutputs, wrapHomeDir } from '../helpers';

// Constants
import { BACKUP_DIR } from './constants';

const VSCODE_COMMAND = '"/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"';
const VSCODE_SETTINGS_PATH = 'Library/Application Support/Code/User/settings.json';

const vscode = (): NodeJS.ReadWriteStream => {
  const extensions = readCommandOutputs(`${VSCODE_COMMAND} --list-extensions`).toString();
  const settings = wrapHomeDir(VSCODE_SETTINGS_PATH);

  return gulp
    .src(settings)
    .pipe(file('extensions', extensions))
    .pipe(gulp.dest(`${BACKUP_DIR}/vscode`));
};

export default vscode;
