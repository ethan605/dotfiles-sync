// Gulp modules
import gulp from 'gulp';

// Helpers
import { wrapHomeDir } from '../helpers';

// Constants
import { BACKUP_DIR } from '../constants';

const SOURCES = ['bindings', 'colors', 'mailcap', 'neomuttrc', 'scripts/*', 'signatures/*'].map(src =>
  wrapHomeDir(`.config/neomutt/${src}`)
);

const neomuttResources = (): NodeJS.ReadWriteStream =>
  gulp.src(SOURCES, { base: wrapHomeDir('.config/neomutt') }).pipe(gulp.dest(`${BACKUP_DIR}/neomutt`));

const mbsyncResources = (): NodeJS.ReadWriteStream =>
  gulp.src(wrapHomeDir('.mbsyncrc')).pipe(gulp.dest(`${BACKUP_DIR}/neomutt`));
const msmtpResources = (): NodeJS.ReadWriteStream =>
  gulp.src(wrapHomeDir('.msmtprc')).pipe(gulp.dest(`${BACKUP_DIR}/neomutt`));

export default gulp.parallel([neomuttResources, mbsyncResources, msmtpResources]);
