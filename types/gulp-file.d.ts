declare module 'gulp-file' {
  import { Transform } from 'stream';

  interface Source {
    name: string;
    source: string;
  }

  interface Options {
    src?: boolean;
  }

  export default function file(
    sourceArray: string | Source[],
    sourceOrOptions?: Buffer | string | Options,
    options?: Options
  ): Transform;
}
