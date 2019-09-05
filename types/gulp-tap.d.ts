declare module 'gulp-tap' {
  import stream, { Transform } from 'stream';
  import VinylFile from 'vinyl';

  interface Utils {
    through: (filter: Function, args: Array) => stream;
  }

  type Callback = (file: VinylFile, utils: Utils) => stream | void;

  export default function tap(callback: Callback): Transform;
}
