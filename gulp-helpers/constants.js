import { wrapHomeDir } from './helpers';

export const BACKUP_DIR = './backup';

export const PASSWORD_PROMPT_SOURCES = [
  {
    path: wrapHomeDir('.gradle/gradle.properties'),
    moduleName: 'gradle',
  },
  {
    path: wrapHomeDir('.ssh/*'),
    moduleName: 'ssh',
  },
];

// IDEs
export const SUBLIME_PACKAGES_PATH = 'Library/Application Support/Sublime Text 3/Packages';
export const SUBLIME_SETTINGS_PATH = `${SUBLIME_PACKAGES_PATH}/User/Preferences.sublime-settings`;
export const VSCODE_COMMAND = '"/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"';
export const VSCODE_SETTINGS_PATH = 'Library/Application Support/Code/User/settings.json';
