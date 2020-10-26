// Gulp modules
import gulp from 'gulp';

// Helpers
import { wrapHomeDir } from '../helpers';

// Constants
import { BACKUP_DIR } from '../constants';

const RESOURCES = ['bindings', 'colors', 'mailcap', 'mbsyncrc', 'msmtprc', 'neomuttrc'].map(src =>
  wrapHomeDir(`.config/neomutt/${src}`)
);

const neomuttResources = (): NodeJS.ReadWriteStream => gulp.src(RESOURCES).pipe(gulp.dest(`${BACKUP_DIR}/neomutt`));
const neomuttScripts = (): NodeJS.ReadWriteStream =>
  gulp.src(wrapHomeDir(`.config/neomutt/scripts/*`)).pipe(gulp.dest(`${BACKUP_DIR}/neomutt/scripts`));
const neomuttSignatures = (): NodeJS.ReadWriteStream =>
  gulp.src(wrapHomeDir(`.config/neomutt/signatures/*`)).pipe(gulp.dest(`${BACKUP_DIR}/neomutt/signatures`));

export default gulp.parallel([neomuttResources, neomuttScripts, neomuttSignatures]);
