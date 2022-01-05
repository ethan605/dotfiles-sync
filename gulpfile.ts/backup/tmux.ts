// Gulp modules
import gulp from 'gulp';

// Helpers
import { wrapHomeDir } from '../helpers';

// Constants
import { BACKUP_DIR } from '../constants';

const SOURCES = ['.tmux.conf', '.tmux.conf.local'].map(src => wrapHomeDir(src));
const tmux = (): NodeJS.ReadWriteStream => gulp.src(SOURCES).pipe(gulp.dest(`${BACKUP_DIR}/tmux`));

export default tmux;
