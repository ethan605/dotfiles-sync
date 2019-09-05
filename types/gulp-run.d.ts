declare module 'gulp-run' {
  import { Transform } from 'stream';
  import Vinyl from 'vinyl';

  enum Verbosity {
    NoPrint = 0, // Do not print anything, ever.
    PrintCmdErr, // Print the command being run and its stderr.
    PrintCmdErrOut, // Print the command, its stderr, and its stdout.
    PrintAllProgressively, // Print the command, its stderr, and its stdout progressively. Not useful if you have concurrent gulp-run instances, as the outputs may get mixed.
  }

  interface Options {
    cwd?: string;
    env?: object;
    silent?: boolean;
    usePowerShell?: boolean;
    verbosity?: Verbosity;
  }

  class GulpRunner extends Transform {
    exec(stdin?: string | Buffer | Vinyl, callback: Function);
  }

  export default function run(template: string, options?: Options): GulpRunner;

  export class Command extends GulpRunner {
    constructor(template: string, options?: Options);
  }
}
