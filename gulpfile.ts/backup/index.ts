import del from 'del';
import gulp from 'gulp';
import vinylPaths from 'vinyl-paths';

// Constants
import { BACKUP_DIR } from '../constants';

import alacritty from './alacritty';
import brew from './brew';
import fonts from './fonts';
import git from './git';
import gnupg from './gnupg';
import karabiner from './karabiner';
import kitty from './kitty';
import launchctl from './launchctl';
import neovim from './neovim';
import nvm from './nvm';
import protectedSources from './protected-sources';
import qmk from './qmk';
import tmux from './tmux';
import vifm from './vifm';
import vim from './vim';
import vscode from './vscode';
import zsh from './zsh';

const cleanUp = (): NodeJS.ReadWriteStream => gulp.src(BACKUP_DIR, { allowEmpty: true }).pipe(vinylPaths(del));

gulp.task(
  'backup',
  gulp.series(
    cleanUp,
    gulp.parallel(
      alacritty,
      brew,
      fonts,
      git,
      gnupg,
      karabiner,
      kitty,
      launchctl,
      neovim,
      nvm,
      protectedSources,
      qmk,
      tmux,
      vifm,
      vim,
      vscode,
      zsh
    )
  )
);
