import _ from 'lodash';
import gulp from 'gulp';
import clean from 'gulp-clean';
import { prompt, Question } from 'gulp-prompt';
import { exec } from 'child_process';
import tap from 'gulp-tap';
import File from 'vinyl';

// Constants
import { BACKUP_DIR } from '../constants';

// Helpers
import { wrapHomeDir } from '../helpers';

const PASSWORD_PROTECTED_SOURCES = [
  {
    moduleName: 'gradle',
    path: wrapHomeDir('.gradle/gradle.properties'),
  },
  {
    moduleName: 'ssh',
    path: wrapHomeDir('.ssh/*'),
  },
];

interface PromptResponse {
  password: string;
  passwordConfirm: string;
}

const prepareZipFolders = gulp.parallel(
  _.map(PASSWORD_PROTECTED_SOURCES, ({ path, moduleName }) => {
    const prepareZipFolder = (): NodeJS.ReadWriteStream => {
      return gulp.src(path).pipe(gulp.dest(`${BACKUP_DIR}/${moduleName}`));
    };

    return prepareZipFolder;
  })
);

const promptPassword = (): NodeJS.ReadWriteStream => {
  const question: Question[] = [
    {
      message: 'Enter password for zip files',
      name: 'password',
      type: 'password',
      validate: (password: string): boolean => {
        if (_.isEmpty(password)) console.log('Password must not be empty!');
        return !_.isEmpty(password);
      },
    },
    {
      message: 'Confirm password for zip files',
      name: 'passwordConfirm',
      type: 'password',
      validate: (passwordConfirm: string, { password }: PromptResponse): boolean => {
        if (password !== passwordConfirm) console.log('Invalid confirmation password!');
        return password === passwordConfirm;
      },
    },
  ];

  let zipPassword = '';

  return gulp
    .src(_.map(PASSWORD_PROTECTED_SOURCES, ({ moduleName }) => `${BACKUP_DIR}/${moduleName}`))
    .pipe(prompt(question, ({ password }: PromptResponse): string => (zipPassword = password)))
    .pipe(tap((file: File) => exec(`cd ${BACKUP_DIR} && zip -P ${zipPassword} -0r ${file.stem}.zip ${file.stem}`)))
    .pipe(clean());
};

export default gulp.series(prepareZipFolders, promptPassword);
