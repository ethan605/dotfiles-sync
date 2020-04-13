// Gulp modules
import gulp from 'gulp';

// Helpers
import { composeZipTask, wrapHomeDir } from '../helpers';
import type { ZipConfig } from '../helpers';

// Constants
import { BACKUP_DIR } from '../constants';

const ZIP_SOURCES: ZipConfig[] = [
  { path: wrapHomeDir('.config/vifm/colors/*'), title: 'colors' },
  { path: wrapHomeDir('.config/vifm/scripts/*'), title: 'scripts' },
];

const vifmrc = (): NodeJS.ReadWriteStream =>
  gulp.src(wrapHomeDir('.config/vifm/vifmrc')).pipe(gulp.dest(`${BACKUP_DIR}/vifm`));

export default gulp.parallel(vifmrc, ...ZIP_SOURCES.map(composeZipTask('vifm')));
