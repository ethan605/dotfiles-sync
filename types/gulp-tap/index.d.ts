declare module 'gulp-tap' {
  import stream, { Transform } from 'stream';
  import File from 'vinyl';

  interface Utils {
    through: (filter: Function, args: any[]) => stream;
  }

  type Callback = (file: File, utils: Utils) => stream | void;

  export default function tap(callback: Callback): Transform;
}
