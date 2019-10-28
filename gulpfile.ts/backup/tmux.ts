// Gulp modules
import gulp from 'gulp';

// Helpers
import { wrapHomeDir } from '../helpers';

// Constants
import { BACKUP_DIR } from '../constants';

const tmux = (): NodeJS.ReadWriteStream => {
  return gulp.src([wrapHomeDir('.tmux.conf'), wrapHomeDir('.tmux.conf.local')]).pipe(gulp.dest(`${BACKUP_DIR}/tmux`));
};

export default tmux;