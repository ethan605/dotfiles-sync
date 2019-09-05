declare module 'gulp-prompt' {
  import { Transform } from 'stream';

  interface ConfirmOption {
    message: string;
    default?: boolean;
  }

  export interface Question {
    choices?: number[] | string[] | object[] | Function;
    default?: string | number | boolean | Array | Function;
    filter?: Function;
    message?: string | Function;
    name?: string;
    pageSize?: number;
    prefix?: number;
    suffix?: number;
    transformer?: Function;
    type?: 'input' | 'number' | 'confirm' | 'list' | 'rawlist' | 'expand' | 'checkbox' | 'password' | 'editor';
    validate?(input: string, answers: object): boolean;
    when?: (answers: object) => boolean | boolean;
  }

  export function confirm(options?: string | ConfirmOption): Transform;
  export function prompt(questions: Question | Question[], callback: Function): Transform;
}
