// Gulp modules
import gulp from 'gulp';
import clean from 'gulp-clean';
import file from 'gulp-file';
import prompt from 'gulp-prompt';
import replace from 'gulp-replace';
import run from 'gulp-run';
import sequence from 'gulp-sequence';

// Helpers
import fs from 'fs';
import _ from 'lodash';
import { readCommandOutputs, wrapHomeDir } from '../helpers';

const BACKUP_DIR = './backup';

// IDEs
const SUBLIME_PACKAGES_PATH = 'Library/Application Support/Sublime Text 3/Packages';
const SUBLIME_SETTINGS_PATH = `${SUBLIME_PACKAGES_PATH}/User/Preferences.sublime-settings`;
const VSCODE_COMMAND = '/Applications/Visual\\ Studio\\ Code.app/Contents/Resources/app/bin/code';
const VSCODE_SETTINGS_PATH = 'Library/Application Support/Code/User/settings.json';

const PASSWORD_PROMPT_SOURCES = [
  {
    path: wrapHomeDir('.gradle/gradle.properties'),
    moduleName: 'gradle',
  },
  {
    path: wrapHomeDir('.ssh/*'),
    moduleName: 'ssh',
  },
];

gulp.task('backup:cleanup', () => gulp.src(BACKUP_DIR).pipe(clean()));

gulp.task('backup:brew', () => {
  const packages = readCommandOutputs('brew list --versions').toString();

  return gulp.src('!dotfiles')
    .pipe(file('packages', packages))
    .pipe(gulp.dest(`${BACKUP_DIR}/brew`));
});

gulp.task('backup:neovim', () => (
  gulp.src(wrapHomeDir('.config/nvim/init.vim'))
    .pipe(gulp.dest(`${BACKUP_DIR}/neovim`))
));

gulp.task('backup:sublime', () => {
  const packages = fs.readdirSync(wrapHomeDir(SUBLIME_PACKAGES_PATH));
  _.remove(packages, filename => (filename === '.DS_Store' || filename === 'User'));

  return gulp.src(wrapHomeDir(SUBLIME_SETTINGS_PATH))
    .pipe(file('packages', packages.join('\n')))
    .pipe(gulp.dest(`${BACKUP_DIR}/sublime`));
});

gulp.task('backup:oh-my-zsh', () => {
  const filePaths = [
    wrapHomeDir('.oh-my-zsh/custom/**/*'),
    wrapHomeDir('.oh-my-zsh/**/*example*', { excluded: true }),
  ];

  const dest = `${BACKUP_DIR}/oh-my-zsh`;

  gulp.src(filePaths).pipe(gulp.dest(dest));
  gulp.src(wrapHomeDir('.zshrc'))
    .pipe(replace(/HOMEBREW_GITHUB_API_TOKEN=".*"/ig, 'HOMEBREW_GITHUB_API_TOKEN=""'))
    .pipe(replace(/JEKYLL_GITHUB_TOKEN=".*"/ig, 'JEKYLL_GITHUB_TOKEN=""'))
    .pipe(gulp.dest(dest));
});

gulp.task('backup:vscode', () => {
  const extensions = readCommandOutputs(`${VSCODE_COMMAND} --list-extensions`).toString();
  const settings = wrapHomeDir(VSCODE_SETTINGS_PATH);

  return gulp.src(settings)
    .pipe(file('extensions', extensions))
    .pipe(gulp.dest(`${BACKUP_DIR}/vscode`));
});

gulp.task('backup:password-prompt:prepare', () => (
  PASSWORD_PROMPT_SOURCES.forEach(({ path, moduleName }) =>
    gulp.src(path).pipe(gulp.dest(`${BACKUP_DIR}/${moduleName}`))
  )
));

gulp.task('backup:password-prompt:prompt', () => {
  const promptConfigs = {
    message: 'Enter password for zip files',
    name: 'password',
    type: 'password',
  };

  const promptHandler = ({ password }) => (
    PASSWORD_PROMPT_SOURCES.forEach(({ moduleName }) => {
      gulp.src(`${BACKUP_DIR}/${moduleName}`)
        .pipe(run(
          `cd ${BACKUP_DIR} && \
          zip -P ${password} -0r ${moduleName}.zip ${moduleName} && \
          rm -rf ${moduleName}`,
          { silent: true, verbosity: 0 }
        ));
    })
  );

  gulp.src('.').pipe(prompt.prompt(promptConfigs, promptHandler));
});

gulp.task('backup:password-prompt', sequence(
  'backup:password-prompt:prepare',
  'backup:password-prompt:prompt'
));

gulp.task('backup', sequence(
  'backup:cleanup',
  [
    'backup:brew',
    'backup:neovim',
    'backup:oh-my-zsh',
    // 'backup:sublime',
    'backup:vscode',
  ],
  'backup:password-prompt'
));
