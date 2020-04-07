import _ from 'lodash';
import Undertaker from 'undertaker';

// Gulp modules
import gulp from 'gulp';
import file from 'gulp-file';

// Helpers
import { readCommandOutputs } from '../helpers';

// Constants
import { BACKUP_DIR } from '../constants';

interface Task {
  command: string;
  title: string;
}

const TASKS: Task[] = [
  { command: 'brew list', title: 'formulaes' },
  { command: 'brew cask list', title: 'casks' },
  { command: 'brew tap', title: 'taps' },
];

const composeBackupTask = ({ command, title }: Task): Undertaker.Task => {
  const output = readCommandOutputs(command).toString();
  const data = _.compact(output.split('\n'));
  const backupTask = (): NodeJS.ReadWriteStream =>
    file(`${title}.json`, JSON.stringify(data), { src: true }).pipe(gulp.dest(`${BACKUP_DIR}/brew`));

  // Rename sub tasks
  Object.defineProperty(backupTask, 'name', { value: `brew${_.capitalize(title)}`, configurable: true });

  return backupTask;
};

export default gulp.parallel(TASKS.map(composeBackupTask));
