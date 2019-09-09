// Definitions by: Ethan N. <https://github.com/ethan605>

declare module 'gulp-tap' {
  import stream, { Transform } from 'stream';
  import File from 'vinyl';

  interface Utils {
    through: (filter: Function, ...args) => stream;
  }

  type Callback = (file: File, utils: Utils) => stream | void;

  export default function tap(callback: Callback): Transform;
}
