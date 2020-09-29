// Gulp modules
import gulp from 'gulp';

// Helpers
import { wrapHomeDir } from '../helpers';

// Constants
import { BACKUP_DIR } from '../constants';

const vifmrc = (): NodeJS.ReadWriteStream =>
  gulp.src(wrapHomeDir('.config/vifm/vifmrc')).pipe(gulp.dest(`${BACKUP_DIR}/vifm`));

export default vifmrc;
