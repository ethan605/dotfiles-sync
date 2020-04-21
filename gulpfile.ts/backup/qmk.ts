// Gulp modules
import gulp from 'gulp';

// Helpers
import { wrapHomeDir } from '../helpers';

// Constants
import { BACKUP_DIR } from '../constants';

const qmk = (): NodeJS.ReadWriteStream =>
  gulp.src(wrapHomeDir('Library/Application Support/qmk/qmk.ini')).pipe(gulp.dest(`${BACKUP_DIR}/qmk`));

export default qmk;
