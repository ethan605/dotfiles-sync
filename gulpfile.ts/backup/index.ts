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
import ohMyZsh from './oh-my-zsh';
import protectedSources from './protected-sources';
import tmux from './tmux';
import vifm from './vifm';
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
      fonts,
      git,
      gnupg,
      karabiner,
      kitty,
      launchctl,
      neovim,
      nvm,
      ohMyZsh,
      protectedSources,
      tmux,
      vifm,
      vim,
      vscode
    )
  )
);
