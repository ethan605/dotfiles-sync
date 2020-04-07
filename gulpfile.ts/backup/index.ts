import del from 'del';
import gulp from 'gulp';
import vinylPaths from 'vinyl-paths';

// Constants
import { BACKUP_DIR } from '../constants';

import alacritty from './alacritty';
import brew from './brew';
import git from './git';
import gnupg from './gnupg';
import karabiner from './karabiner';
import kitty from './kitty';
import neovim from './neovim';
import nvm from './nvm';
import ohMyZsh from './oh-my-zsh';
import protectedSources from './protected-sources';
import tmux from './tmux';
import vim from './vim';
import vscode from './vscode';

const cleanUp = (): NodeJS.ReadWriteStream => gulp.src(BACKUP_DIR, { allowEmpty: true }).pipe(vinylPaths(del));

gulp.task(
  'backup',
  gulp.series(
    cleanUp,
    gulp.parallel(
      alacritty,
      brew,
      git,
      gnupg,
      karabiner,
      kitty,
      neovim,
      nvm,
      ohMyZsh,
      protectedSources,
      tmux,
      vim,
      vscode
    )
  )
);
