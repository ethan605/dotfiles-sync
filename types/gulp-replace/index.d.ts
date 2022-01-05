// Definitions by: Ethan N. <https://github.com/ethan605>

declare module 'gulp-replace' {
  import { Transform } from 'stream';

  interface Options {
    skipBinary?: boolean;
  }

  type ReplaceFunction = (match: string, p1?: string, offset?: number, string?: string) => string;

  export default function replace(
    search: RegExp | string,
    replace: ReplaceFunction | string,
    options?: Options
  ): Transform;
}
