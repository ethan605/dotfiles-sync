declare module 'gulp-file' {
  import { Transform } from 'stream';

  export interface Source {
    name: string;
    source: string | Buffer;
  }

  interface Options {
    src?: boolean;
  }

  function file(name: string, source: Buffer | string, options?: Options): Transform;
  function file(sourceArray: string | Source[], options?: Options): Transform;

  export default file;
}
