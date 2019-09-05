declare module 'gulp-clean' {
  import { Transform } from 'stream';

  interface Options {
    force?: boolean;
    read?: boolean;
  }

  export default function clean(options?: Options): Transform;
}
