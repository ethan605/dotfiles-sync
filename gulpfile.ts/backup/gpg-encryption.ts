import { execSync } from 'child_process';
import _ from 'lodash';
import del from 'del';
import gulp from 'gulp';
import vinylPaths from 'vinyl-paths';
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
  const vPaths = vinylPaths();
  const { path, title } = source;
  const target = [BACKUP_DIR, title].join('/');

  const taskName = `encrypt${_.capitalize(title)}`;

  const encryptTask = (): NodeJS.ReadWriteStream =>
    gulp
      .src(path)
      .pipe(gulp.dest(target))
      .pipe(vPaths)
      .on('end', async () => {
        execSync(`
          cd ${target} &&
          gpgtar --encrypt --sign --recipient ${GPG_RECIPIENT} --output ../${title}.gpgtar *
        `);

        await del(vPaths.paths);
      });

  Object.defineProperty(encryptTask, 'name', { value: taskName, configurable: true });

  return encryptTask;
};

// gulp.task('gpg-encryption', gulp.parallel(_.map(PROTECTED_SOURCES, source => encryptSource(source))));

export default gulp.parallel(_.map(PROTECTED_SOURCES, source => encryptSource(source)));
