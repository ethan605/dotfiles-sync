// Definitions by: Ethan N. <https://github.com/ethan605>

declare module 'gulp-prompt' {
  import { Transform } from 'stream';

  export interface ChainResponse {
    val: boolean;
  }

  export type CallbackHandler = ({ [key in string]: string }) => void;

  export interface Question {
    choices?: number[] | string[] | object[] | Function;
    default?: string | number | boolean | Array | Function;
    filter?: Function;
    message: string | Function;
    name?: string;
    pageSize?: number;
    prefix?: number;
    suffix?: number;
    templateOptions?: { [key in string]: string };
    transformer?: Function;
    type?: 'input' | 'number' | 'confirm' | 'list' | 'rawlist' | 'expand' | 'checkbox' | 'password' | 'editor';
    chainFunction?(options: Question, response: ChainResponse): Question | undefined;
    validate?(input: string, answers: object): boolean;
    when?(answers: object): boolean;
  }

  export function confirm(options?: string | Question, callback?: CallbackHandler): Transform;
  export function prompt(questions: Question | Question[], callback: CallbackHandler): Transform;
}
