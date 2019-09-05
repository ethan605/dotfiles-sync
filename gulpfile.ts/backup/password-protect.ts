import _ from 'lodash';
import gulp from 'gulp';
import { prompt, Question } from 'gulp-prompt';
import run from 'gulp-run';

// Constants
import { BACKUP_DIR, PASSWORD_PROMPT_SOURCES } from './constants';

interface PromptResponse {
  password: string;
  passwordConfirm: string;
}

const validatePasswords = (passwordConfirm: string, { password }: PromptResponse): boolean => {
  if (password !== passwordConfirm) console.log('Invalid confirmation password!');
  return password === passwordConfirm;
};

const handlePasswordPrompted = ({ password }: PromptResponse): void => {
  _.each(PASSWORD_PROMPT_SOURCES, ({ moduleName }) => {
    gulp.src(`${BACKUP_DIR}/${moduleName}`).pipe(
      run(
        `cd ${BACKUP_DIR} && \
          zip -P ${password} -0r ${moduleName}.zip ${moduleName} && \
          rm -rf ${moduleName}`,
        { silent: true, verbosity: 0 }
      )
    );
  });
};

const prepareZipFolders = (callback: Function): void => {
  _.each(PASSWORD_PROMPT_SOURCES, ({ path, moduleName }) =>
    gulp.src(path).pipe(gulp.dest(`${BACKUP_DIR}/${moduleName}`))
  );

  callback();
};

const promptPassword = (): NodeJS.ReadWriteStream => {
  const question: Question[] = [
    {
      message: 'Enter password for zip files',
      name: 'password',
      type: 'password',
    },
    {
      message: 'Confirm password for zip files',
      name: 'passwordConfirm',
      type: 'password',
      validate: validatePasswords,
    },
  ];

  return gulp.src('.').pipe(prompt(question, handlePasswordPrompted));
};

export default gulp.series(prepareZipFolders, promptPassword);
