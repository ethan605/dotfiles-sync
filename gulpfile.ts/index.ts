import './backup';

import gulp from 'gulp';
import { confirm, Question, ChainResponse } from 'gulp-prompt';

let counter = 0;

const chainFunction = (options: Question, resp: ChainResponse): Question => {
  console.log('Here is the selection', options, resp);

  if (counter === 0) {
    counter += 1;

    return {
      ...options,
      message: 'Second interation, please enter selection?',
    };
  }

  return undefined;
};

/**
 * The following is a sample gulp file for chaining requests.  It
 * will pass a chaining function to the confirm function and will
 * allow the user to chain multiple requests together
 * variables
 *
 */
gulp.task('chainConfirm', cb => {
  gulp.src('package.json', { allowEmpty: true }).pipe(
    confirm(
      {
        type: 'input',
        name: 'env',
        message: 'Hello First interation, please enter selection?',
        chainFunction: chainFunction,
      },
      res => console.log('Result', res)
    )
  );

  cb();
});
