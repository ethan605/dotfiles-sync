import { execSync } from 'child_process';
import _ from 'lodash';
import Undertaker from 'undertaker';

// Gulp modules
import gulp from 'gulp';
import file from 'gulp-file';

import { BACKUP_DIR } from './constants';

interface WrapperOptions {
  excluded?: boolean;
}

export interface ReadCommandTask {
  command: string;
  title: string;
}

export const readCommandOutputs = (...commands: string[]): string[] =>
  commands.map(command => execSync(command).toString());

export const composeReadCommandTask = (prefix: string) => ({ command, title }: ReadCommandTask): Undertaker.Task => {
  const output = readCommandOutputs(command).toString();
  const data = _.compact(output.split('\n'));
  const backupTask = (): NodeJS.ReadWriteStream =>
    file(`${title}.json`, JSON.stringify(data), { src: true }).pipe(gulp.dest([BACKUP_DIR, prefix].join('/')));

  // Rename sub tasks
  Object.defineProperty(backupTask, 'name', { value: [prefix, _.capitalize(title)].join(''), configurable: true });

  return backupTask;
};

export const wrapHomeDir = (filename: string, opts: WrapperOptions = {}): string => {
  const { excluded = false } = opts;
  return `${excluded ? '!' : ''}${process.env.HOME}/${filename}`;
};
