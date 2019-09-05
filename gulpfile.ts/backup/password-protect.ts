import { execSync } from 'child_process';
import _ from 'lodash';
import del from 'del';
import gulp from 'gulp';
import { prompt, Question } from 'gulp-prompt';
import path from 'path';
import vinylPaths from 'vinyl-paths';

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
  const vPaths = vinylPaths();

  return gulp
    .src(_.map(PASSWORD_PROTECTED_SOURCES, ({ moduleName }) => `${BACKUP_DIR}/${moduleName}`))
    .pipe(prompt(question, ({ password }: PromptResponse): string => (zipPassword = password)))
    .pipe(vPaths)
    .on('end', async () => {
      _.map(vPaths.paths, pathName => {
        const fileName = path.parse(pathName).base;
        execSync(`cd ${BACKUP_DIR} && zip -P ${zipPassword} -0r ${fileName}.zip ${fileName}`);
      });
      await del(vPaths.paths);
    });
};

export default gulp.series(prepareZipFolders, promptPassword);
