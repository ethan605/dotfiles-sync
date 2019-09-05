declare module 'gulp-file' {
  import { Transform } from 'stream';

  export interface Source {
    name: string;
    source: string | Buffer;
  }

  interface Options {
    src?: boolean;
  }

  type SingleFileHandler = (name: string, source: Buffer | string, options?: Options) => Transform;
  type MultipleFilesHandler = (sourceArray: string | Source[], options?: Options) => Transform;

  const file: SingleFileHandler | MultipleFilesHandler;
  export default file;

  // export default function file(
  //   source: Source[],
  //   sourceArrayOrOptions?: (string & Options) | (Buffer & Options),
  //   options?: Options
  // ): Transform;
}
