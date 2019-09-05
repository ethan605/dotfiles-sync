// Gulp modules
import gulp from 'gulp';
import clean from 'gulp-clean';

// Constants
import { BACKUP_DIR } from '../constants';

import brew from './brew';
import hyper from './hyper';
import './karabiner';
import './neovim';
import './oh-my-zsh';
import './password-protect';
import './sublime';
import './vscode';

const cleanUp = (): NodeJS.ReadWriteStream => gulp.src(BACKUP_DIR, { allowEmpty: true }).pipe(clean());

gulp.task(
  'backup',
  gulp.series(
    cleanUp,
    gulp.parallel(
      brew,
      hyper
      // 'backup:karabiner',
      // 'backup:neovim',
      // 'backup:oh-my-zsh',
      // 'backup:vscode'
    )
    // 'backup:password-protect'
  )
);
