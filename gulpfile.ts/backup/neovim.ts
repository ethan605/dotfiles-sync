// Gulp modules
import gulp from 'gulp';

// Helpers
import { wrapHomeDir } from '../helpers';

// Constants
import { BACKUP_DIR } from './constants';

const neovim = (): NodeJS.ReadWriteStream => {
  return gulp.src(wrapHomeDir('.config/nvim/init.vim')).pipe(gulp.dest(`${BACKUP_DIR}/neovim`));
};

export default neovim;
