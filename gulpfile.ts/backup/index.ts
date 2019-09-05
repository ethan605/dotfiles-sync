// Gulp modules
import gulp from 'gulp';
import clean from 'gulp-clean';

// Constants
import { BACKUP_DIR } from './constants';

import brew from './brew';
import hyper from './hyper';
import karabiner from './karabiner';
import neovim from './neovim';
import ohMyZsh from './oh-my-zsh';
import sublime from './sublime';
import vscode from './vscode';
import passwordProtect from './password-protect';

const cleanUp = (): NodeJS.ReadWriteStream => gulp.src(BACKUP_DIR, { allowEmpty: true }).pipe(clean());

gulp.task(
  'backup',
  gulp.series(cleanUp, gulp.parallel(brew, hyper, karabiner, neovim, ohMyZsh, sublime, vscode), passwordProtect)
);
