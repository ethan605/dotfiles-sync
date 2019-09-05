declare module 'gulp-clean' {
  import { Transform } from 'stream';

  interface Options {
    force?: boolean;
    read?: boolean;
  }

  export default function clean(options?: Options): Transform;
}

declare module 'gulp-exec' {
  import { Transform } from 'stream';

  interface ExecOptions {
    continueOnError?: boolean;
    encoding?: string;
    env?: string;
    pipeStdout?: boolean;
  }

  interface ReportOptions {
    err?: boolean;
    stderr?: boolean;
    stdout?: boolean;
  }

  export function reporter(options?: ReportOptions): Transform;
  export default function exec(command: string, options?: ExecOptions): Transform;
}
