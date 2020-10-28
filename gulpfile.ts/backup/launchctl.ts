// Gulp modules
import gulp from 'gulp';

// Helpers
import { wrapHomeDir } from '../helpers';

// Constants
import { BACKUP_DIR } from '../constants';

const SOURCES = ['ethanify.dotfiles.backup', 'ethanify.dotfiles.mbsync'].map(src =>
  wrapHomeDir(`Library/LaunchAgents/${src}.plist`)
);

const launchctl = (): NodeJS.ReadWriteStream => gulp.src(SOURCES).pipe(gulp.dest(`${BACKUP_DIR}/launchctl`));

export default launchctl;
