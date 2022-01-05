// Gulp modules
import gulp from 'gulp';
import gulpRename from 'gulp-rename';

// Helpers
import { wrapHomeDir } from '../helpers';

// Constants
import { BACKUP_DIR } from '../constants';

const dest = `${BACKUP_DIR}/neovim`;

const neovimInit = (): NodeJS.ReadWriteStream => gulp.src(wrapHomeDir('.config/nvim/init.vim')).pipe(gulp.dest(dest));

const neovimCoc = (): NodeJS.ReadWriteStream =>
  gulp
    .src(wrapHomeDir('.config/coc/extensions/package.json'))
    .pipe(gulpRename({ basename: 'coc-extensions', extname: '.json' }))
    .pipe(gulp.dest(dest));

export default gulp.parallel(neovimInit, neovimCoc);
