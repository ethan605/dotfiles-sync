// Gulp modules
import gulp from 'gulp';

// Helpers
import { wrapHomeDir } from '../helpers';

// Constants
import { BACKUP_DIR } from '../constants';

const SOURCES = [
  'bindings',
  'colors',
  'mailcap',
  'mbsyncrc',
  'msmtprc',
  'neomuttrc',
  'scripts/*',
  'signatures/*',
].map(src => wrapHomeDir(`.config/neomutt/${src}`));

const neomutt = (): NodeJS.ReadWriteStream =>
  gulp.src(SOURCES, { base: wrapHomeDir('.config/neomutt') }).pipe(gulp.dest(`${BACKUP_DIR}/neomutt`));

export default neomutt;