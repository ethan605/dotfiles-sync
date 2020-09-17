// Gulp modules
import gulp from 'gulp';
import replace from 'gulp-replace';

// Helpers
import { wrapHomeDir } from '../helpers';

// Constants
import { BACKUP_DIR } from '../constants';

const DEST_DIR = `${BACKUP_DIR}/zsh`;

const zshrc = (): NodeJS.ReadWriteStream =>
  gulp
    .src(wrapHomeDir('.zshrc'))
    .pipe(replace(/SDK_TOKEN_FACTORY_SECRET=".*"/, 'SDK_TOKEN_FACTORY_SECRET=""'))
    .pipe(replace(/LOKALISE_TOKEN=".*"/, 'LOKALISE_TOKEN=""'))
    .pipe(replace(/LOKALISE_PROJECT_ID=".*"/, 'LOKALISE_PROJECT_ID=""'))
    .pipe(replace(/BROWSERSTACK_USERNAME=".*"/, 'BROWSERSTACK_USERNAME=""'))
    .pipe(replace(/BROWSERSTACK_ACCESS_KEY=".*"/, 'BROWSERSTACK_ACCESS_KEY=""'))
    .pipe(gulp.dest(DEST_DIR));

export default zshrc;
