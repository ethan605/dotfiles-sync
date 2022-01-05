// Gulp modules
import gulp from 'gulp';

// Helpers
import { wrapHomeDir } from '../helpers';

// Constants
import { BACKUP_DIR } from '../constants';

const SOURCES = ['.gnupg/*.conf', '.gnupg/pubring.*'].map(src => wrapHomeDir(src));
const gnupg = (): NodeJS.ReadWriteStream => gulp.src(SOURCES).pipe(gulp.dest(`${BACKUP_DIR}/gnupg`));

export default gnupg;
