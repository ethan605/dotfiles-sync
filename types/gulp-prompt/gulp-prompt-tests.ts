import { confirm, prompt, Question, ChainResponse } from 'gulp-prompt';

// Confirm, no options
confirm();

// Confirm, plain message
confirm('Are you ready for Gulp?');

// Confirm, plain message, callback
confirm('Are you ready for Gulp?', response => console.log(response));

// Confirm, structured options
confirm({ message: 'Are you ready for Gulp?' });

// Confirm, structured options, callback
confirm({ message: 'Are you ready for Gulp?' }, response => console.log(response));

// Confirm, structured options
confirm({ message: 'Are you ready for Gulp?', default: false });
confirm({ message: 'Are you ready for Gulp?', default: true });

// Confirm, structured options, callback
confirm({ message: 'Are you ready for Gulp?', default: false }, response => console.log(response));
confirm({ message: 'Are you ready for Gulp?', default: true }, response => console.log(response));

// Confirm, structured options, chain confirm
confirm(
  {
    type: 'input',
    name: 'env',
    message: 'Hello First interation, please enter selection?',
    chainFunction: (options: Question, response: ChainResponse): Question => {
      console.log(options, response);
      return undefined;
    },
  },
  response => console.log(response)
);

// Confirm, templating
confirm(
  {
    type: 'input',
    name: 'env',
    message: 'Hello <%= user %>, please enter selection?',
    templateOptions: { user: 'fred' },
  },
  response => console.log(response)
);

// Prompt, input
prompt(
  {
    type: 'input',
    name: 'task',
    message: 'Which task would you like to run?',
  },
  response => console.log(response)
);

// Prompt, checkbox
prompt(
  {
    type: 'checkbox',
    name: 'bump',
    message: 'What type of bump would you like to do?',
    choices: ['patch', 'minor', 'major'],
  },
  response => console.log(response)
);

// Prompt, password
prompt(
  {
    type: 'password',
    name: 'pass',
    message: 'Please enter your password',
  },
  response => console.log(response)
);

// Prompt, multiple
prompt(
  [
    {
      type: 'input',
      name: 'first',
      message: 'First question?',
    },
    {
      type: 'input',
      name: 'second',
      message: 'Second question?',
    },
  ],
  response => console.log(response)
);

// Prompt, validation
prompt(
  {
    type: 'password',
    name: 'password',
    message: 'Please enter your password',
    validate: pwd => pwd.length >= 8,
  },
  response => console.log(response)
);

// Prompt, list selection
prompt(
  {
    type: 'list',
    name: 'env',
    message: 'Please enter selection?',
    choices: ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'],
    pageSize: 3,
  },
  response => console.log(response)
);
