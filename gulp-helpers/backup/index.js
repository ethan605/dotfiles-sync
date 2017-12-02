// Gulp modules
import gulp from 'gulp';
import clean from 'gulp-clean';
import sequence from 'gulp-sequence';

// Constants
import { BACKUP_DIR } from '../constants';

import './brew';
import './karabiner';
import './neovim';
import './oh-my-zsh';
import './password-protect';
import './sublime';
import './vscode';

gulp.task('backup:cleanup', () => gulp.src(BACKUP_DIR).pipe(clean()));

gulp.task('backup', sequence(
  'backup:cleanup',
  [
    'backup:brew',
    'backup:karabiner',
    'backup:neovim',
    'backup:oh-my-zsh',
    'backup:vscode',
  ],
  'backup:password-protect'
));
