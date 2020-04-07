// Gulp modules
import gulp from 'gulp';
import replace from 'gulp-replace';

// Helpers
import { wrapHomeDir } from '../helpers';

// Constants
import { BACKUP_DIR } from '../constants';

const DEST_DIR = `${BACKUP_DIR}/oh-my-zsh`;

const ohMyZshCustoms = (): NodeJS.ReadWriteStream =>
  gulp
    .src([wrapHomeDir('.oh-my-zsh/custom/**/*'), wrapHomeDir('.oh-my-zsh/**/*example*', { excluded: true })])
    .pipe(gulp.dest(DEST_DIR));

const ohMyZshRemoveSensitiveData = (): NodeJS.ReadWriteStream =>
  gulp
    .src(wrapHomeDir('.zshrc'))
    .pipe(replace(/HOMEBREW_GITHUB_API_TOKEN=".*"/, 'HOMEBREW_GITHUB_API_TOKEN=""'))
    .pipe(replace(/JEKYLL_GITHUB_TOKEN=".*"/, 'JEKYLL_GITHUB_TOKEN=""'))
    .pipe(replace(/PITOP_GITHUB_TOKEN=".*"/, 'PITOP_GITHUB_TOKEN=""'))
    .pipe(replace(/GOOGLE_APPLICATION_CREDENTIALS=".*"/, 'GOOGLE_APPLICATION_CREDENTIALS=""'))
    .pipe(replace(/GOOGLE_PROJECT_ID=".*"/, 'GOOGLE_PROJECT_ID=""'))
    .pipe(gulp.dest(DEST_DIR));

export default gulp.parallel(ohMyZshCustoms, ohMyZshRemoveSensitiveData);
