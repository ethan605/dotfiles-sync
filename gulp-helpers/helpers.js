// Helpers
import childProcess from 'child_process';

export function readCommandOutputs(...commands) {
  return commands.map(command => (
    childProcess.execSync(command).toString())
  );
}

export function wrapHomeDir(filename, opts = {}) {
  const { excluded = false } = opts;
  return `${excluded ? '!' : ''}${process.env.HOME}/${filename}`;
}
