// Gulp modules
import gulp from 'gulp';
import replace from 'gulp-replace';

// Helpers
import { wrapHomeDir } from '../helpers';

// Constants
import { BACKUP_DIR } from '../constants';

gulp.task('backup:oh-my-zsh', () => {
  const filePaths = [
    wrapHomeDir('.oh-my-zsh/custom/**/*'),
    wrapHomeDir('.oh-my-zsh/**/*example*', { excluded: true }),
  ];

  const dest = `${BACKUP_DIR}/oh-my-zsh`;

  gulp.src(filePaths).pipe(gulp.dest(dest));
  gulp.src(wrapHomeDir('.zshrc'))
    .pipe(replace(/HOMEBREW_GITHUB_API_TOKEN=".*"/ig, 'HOMEBREW_GITHUB_API_TOKEN=""'))
    .pipe(replace(/JEKYLL_GITHUB_TOKEN=".*"/ig, 'JEKYLL_GITHUB_TOKEN=""'))
    .pipe(gulp.dest(dest));
});
