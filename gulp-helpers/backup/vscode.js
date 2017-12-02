// Gulp modules
import gulp from 'gulp';
import file from 'gulp-file';

// Helpers
import { readCommandOutputs, wrapHomeDir } from '../helpers';

// Constants
import { BACKUP_DIR, VSCODE_COMMAND, VSCODE_SETTINGS_PATH } from '../constants';

gulp.task('backup:vscode', () => {
  const extensions = readCommandOutputs(`${VSCODE_COMMAND} --list-extensions`).toString();
  const settings = wrapHomeDir(VSCODE_SETTINGS_PATH);

  return gulp.src(settings)
    .pipe(file('extensions', extensions))
    .pipe(gulp.dest(`${BACKUP_DIR}/vscode`));
});
