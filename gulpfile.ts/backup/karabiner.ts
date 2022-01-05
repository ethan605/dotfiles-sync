// Gulp modules
import gulp from 'gulp';

// Helpers
import { wrapHomeDir } from '../helpers';

// Constants
import { BACKUP_DIR } from '../constants';

const karabiner = (): NodeJS.ReadWriteStream =>
  gulp.src(wrapHomeDir('.config/karabiner/karabiner.json')).pipe(gulp.dest(`${BACKUP_DIR}/karabiner`));

export default karabiner;
