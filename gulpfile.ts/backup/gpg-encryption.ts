import { execSync } from 'child_process';
import _ from 'lodash';
import del from 'del';
import gulp from 'gulp';
import Undertaker from 'undertaker';

// Constants
import { BACKUP_DIR, GPG_RECIPIENT } from '../constants';

// Helpers
import { wrapHomeDir } from '../helpers';

interface Source {
  path: string;
  title: string;
}

const PROTECTED_SOURCES: Source[] = [
  {
    path: wrapHomeDir('.gradle/gradle.properties'),
    title: 'gradle',
  },
  {
    path: wrapHomeDir('.ssh/*'),
    title: 'ssh',
  },
];

const encryptSource = (source: Source): Undertaker.Task => {
  const { path, title } = source;
  const target = [BACKUP_DIR, title].join('/');
  const options = ['--encrypt', '--sign', `--recipient ${GPG_RECIPIENT}`, `--output ../${title}.gpgtar`].join(' ');

  const encryptTask = (): NodeJS.ReadWriteStream =>
    gulp
      .src(path)
      .pipe(gulp.dest(target))
      .on('end', async () => {
        execSync(`cd ${target} && gpgtar ${options} * &> /dev/null`);
        await del(target);
      });

  // Rename sub tasks
  Object.defineProperty(encryptTask, 'name', { value: `encrypt${_.capitalize(title)}`, configurable: true });

  return encryptTask;
};

export default gulp.parallel(_.map(PROTECTED_SOURCES, source => encryptSource(source)));
