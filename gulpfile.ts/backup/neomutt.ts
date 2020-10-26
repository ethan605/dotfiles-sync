// Gulp modules
import gulp from 'gulp';

// Helpers
import { wrapHomeDir } from '../helpers';

// Constants
import { BACKUP_DIR } from '../constants';

const SOURCES = ['bindings', 'colors', 'mailcap', 'mbsyncrc', 'neomuttrc', 'scripts/*'].map(src =>
  wrapHomeDir(`.config/neomutt/${src}`)
);

const neomutt = (): NodeJS.ReadWriteStream => gulp.src(SOURCES).pipe(gulp.dest(`${BACKUP_DIR}/neomutt`));

export default neomutt;
