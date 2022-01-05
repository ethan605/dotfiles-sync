// Gulp modules
import gulp from 'gulp';

// Helpers
import { wrapHomeDir } from '../helpers';

// Constants
import { BACKUP_DIR } from '../constants';

const alacritty = (): NodeJS.ReadWriteStream =>
  gulp.src(wrapHomeDir('.config/alacritty/alacritty.yml')).pipe(gulp.dest(`${BACKUP_DIR}/alacritty`));

export default alacritty;
