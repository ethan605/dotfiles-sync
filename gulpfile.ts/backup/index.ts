import del from 'del';
import gulp from 'gulp';
import vinylPaths from 'vinyl-paths';

// Constants
import { BACKUP_DIR } from '../constants';

import brew from './brew';
import git from './git';
import gnupg from './gnupg';
import hyper from './hyper';
import karabiner from './karabiner';
import kitty from './kitty';
import neovim from './neovim';
import ohMyZsh from './oh-my-zsh';
import passwordProtect from './password-protect';
import sublime from './sublime';
import vscode from './vscode';

const cleanUp = (): NodeJS.ReadWriteStream => gulp.src(BACKUP_DIR, { allowEmpty: true }).pipe(vinylPaths(del));

gulp.task(
  'backup',
  gulp.series(
    cleanUp,
    gulp.parallel(brew, git, gnupg, hyper, karabiner, kitty, neovim, ohMyZsh, sublime, vscode),
    passwordProtect
  )
);
