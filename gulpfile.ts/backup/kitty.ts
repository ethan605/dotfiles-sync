// Gulp modules
import gulp from 'gulp';

// Helpers
import { wrapHomeDir } from '../helpers';

// Constants
import { BACKUP_DIR } from '../constants';

const kitty = (): NodeJS.ReadWriteStream =>
  gulp.src(wrapHomeDir('.config/kitty/**/*.conf')).pipe(gulp.dest(`${BACKUP_DIR}/kitty`));

export default kitty;
