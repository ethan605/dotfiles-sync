// Helpers
import childProcess from 'child_process';

export const readCommandOutputs = (...commands: string[]): string[] =>
  commands.map(command => childProcess.execSync(command).toString());

interface WrapperOptions {
  excluded?: boolean;
}

export const wrapHomeDir = (filename: string, opts: WrapperOptions = {}): string => {
  const { excluded = false } = opts;
  return `${excluded ? '!' : ''}${process.env.HOME}/${filename}`;
};
