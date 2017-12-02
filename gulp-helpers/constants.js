import { wrapHomeDir } from './helpers';

export const BACKUP_DIR = './backup';

export const PASSWORD_PROMPT_SOURCES = [
  {
    moduleName: 'gradle',
    path: wrapHomeDir('.gradle/gradle.properties'),
  },
  {
    moduleName: 'ssh',
    path: wrapHomeDir('.ssh/*'),
  },
];
