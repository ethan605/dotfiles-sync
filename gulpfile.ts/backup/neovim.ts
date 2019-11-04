// Gulp modules
import gulp from 'gulp';
import gulpRename from 'gulp-rename';

// Helpers
import { wrapHomeDir } from '../helpers';

// Constants
import { BACKUP_DIR } from '../constants';

const dest = `${BACKUP_DIR}/neovim`;

const copyInitVim = (): NodeJS.ReadWriteStream => gulp.src(wrapHomeDir('.config/nvim/init.vim')).pipe(gulp.dest(dest));

const copyCocExtensions = (): NodeJS.ReadWriteStream =>
  gulp
    .src(wrapHomeDir('.config/coc/package.json'))
    .pipe(gulpRename({ basename: 'coc-packages', extname: 'json' }))
    .pipe(gulp.dest(dest));

export default gulp.parallel(copyInitVim, copyCocExtensions);
