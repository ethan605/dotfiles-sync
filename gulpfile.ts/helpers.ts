import _ from 'lodash';
import { execSync } from 'child_process';

export const readCommandOutputs = (...commands: string[]): string[] =>
  _.map(commands, command => execSync(command).toString());

interface WrapperOptions {
  excluded?: boolean;
}

export const wrapHomeDir = (filename: string, opts: WrapperOptions = {}): string => {
  const { excluded = false } = opts;
  return `${excluded ? '!' : ''}${process.env.HOME}/${filename}`;
};
