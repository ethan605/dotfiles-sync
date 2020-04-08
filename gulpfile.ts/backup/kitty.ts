// Gulp modules
import gulp from 'gulp';

// Helpers
import { composeZipTask, wrapHomeDir } from '../helpers';
import type { ZipConfig } from '../helpers';

// Constants
import { BACKUP_DIR } from '../constants';

const ZIP_SOURCES: ZipConfig[] = [{ path: wrapHomeDir('.config/kitty/colorschemes/*'), title: 'colorschemes' }];

const kittyConf = (): NodeJS.ReadWriteStream =>
  gulp.src(wrapHomeDir('.config/kitty/kitty.conf')).pipe(gulp.dest(`${BACKUP_DIR}/kitty`));

export default gulp.parallel(kittyConf, ...ZIP_SOURCES.map(composeZipTask('kitty')));
