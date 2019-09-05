// Gulp modules
import gulp from 'gulp';
import prompt from 'gulp-prompt';
import run from 'gulp-run';

// Constants
import { BACKUP_DIR, PASSWORD_PROMPT_SOURCES } from '../constants';

const prepare = (callback: Function): void => {
  PASSWORD_PROMPT_SOURCES.forEach(({ path, moduleName }) =>
    gulp.src(path).pipe(gulp.dest(`${BACKUP_DIR}/${moduleName}`))
  );
  callback();
};

const promptPassword = (): NodeJS.ReadWriteStream => {
  const promptConfigs = {
    message: 'Enter password for zip files',
    name: 'password',
    type: 'password',
  };

  const promptHandler = ({ password }) =>
    PASSWORD_PROMPT_SOURCES.forEach(({ moduleName }) => {
      gulp.src(`${BACKUP_DIR}/${moduleName}`).pipe(
        run(
          `cd ${BACKUP_DIR} && \
          zip -P ${password} -0r ${moduleName}.zip ${moduleName} && \
          rm -rf ${moduleName}`,
          { silent: true, verbosity: 0 }
        )
      );
    });

  return gulp.src('.').pipe(prompt.prompt(promptConfigs, promptHandler));
};

gulp.task('backup:password-protect', gulp.series(prepare, promptPassword));
