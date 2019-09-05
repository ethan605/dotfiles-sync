// Gulp modules
import gulp from 'gulp';
import replace from 'gulp-replace';

// Helpers
import { wrapHomeDir } from '../helpers';

// Constants
import { BACKUP_DIR } from '../constants';

const dest = `${BACKUP_DIR}/oh-my-zsh`;

const copyFiles = (): NodeJS.ReadWriteStream =>
  gulp
    .src([wrapHomeDir('.oh-my-zsh/custom/**/*'), wrapHomeDir('.oh-my-zsh/**/*example*', { excluded: true })])
    .pipe(gulp.dest(dest));

const removeSensitiveData = (): NodeJS.ReadWriteStream =>
  gulp
    .src(wrapHomeDir('.zshrc'))
    .pipe(replace(/HOMEBREW_GITHUB_API_TOKEN=".*"/gi, 'HOMEBREW_GITHUB_API_TOKEN=""'))
    .pipe(replace(/JEKYLL_GITHUB_TOKEN=".*"/gi, 'JEKYLL_GITHUB_TOKEN=""'))
    .pipe(gulp.dest(dest));

const ohMyZsh = (callback: Function): void => {
  copyFiles();
  removeSensitiveData();
  callback();
};

export default ohMyZsh;
