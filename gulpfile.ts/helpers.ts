import { execSync } from 'child_process';
import del from 'del';
import _ from 'lodash';
import path from 'path';
import vinylPaths from 'vinyl-paths';
import Undertaker from 'undertaker';

// Gulp modules
import gulp from 'gulp';
import file from 'gulp-file';

import { BACKUP_DIR } from './constants';

interface WrapperOptions {
  excluded?: boolean;
}

export interface ZipConfig {
  path: string;
  title: string;
}

export interface ReadCommandConfig {
  command: string;
  title: string;
}

export const readCommandOutputs = (...commands: string[]): string[] =>
  commands.map(command => execSync(command).toString());

export const composeReadCommandTask = (prefix: string) => (config: ReadCommandConfig): Undertaker.Task => {
  const { command, title } = config;
  const output = readCommandOutputs(command).toString();
  const data = _.compact(output.split('\n'));
  const backupTask = (): NodeJS.ReadWriteStream =>
    file(`${title}.json`, JSON.stringify(data), { src: true }).pipe(gulp.dest([BACKUP_DIR, prefix].join('/')));

  // Rename sub tasks
  Object.defineProperty(backupTask, 'name', { value: [prefix, _.capitalize(title)].join(''), configurable: true });

  return backupTask;
};

export const composeZipTask = (prefix: string) => (config: ZipConfig): Undertaker.Task => {
  const { path: srcPath, title } = config;
  const destPath = `${BACKUP_DIR}/${title}`;

  const zipTask = (): NodeJS.ReadWriteStream =>
    gulp
      .src(srcPath)
      .pipe(gulp.dest(destPath))
      .on('end', async () => {
        execSync(`cd ${BACKUP_DIR} && zip -0r ${title}.zip ${title}/*`);
        await del(destPath);
      });

  // Rename sub tasks
  Object.defineProperty(zipTask, 'name', { value: [prefix, _.capitalize(title)].join(''), configurable: true });

  return zipTask;
};

export const wrapHomeDir = (filename: string, opts: WrapperOptions = {}): string => {
  const { excluded = false } = opts;
  return `${excluded ? '!' : ''}${process.env.HOME}/${filename}`;
};
