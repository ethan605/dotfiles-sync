// Gulp modules
import gulp from 'gulp';

// Helpers
import { wrapHomeDir } from '../helpers';

// Constants
import { BACKUP_DIR } from '../constants';

const launchctl = (): NodeJS.ReadWriteStream =>
  gulp
    .src(wrapHomeDir('Library/LaunchAgents/ethanify.dotfiles.backup.plist'))
    .pipe(gulp.dest(`${BACKUP_DIR}/launchctl`));

gulp.task('launchctl', launchctl);
export default launchctl;
