// Gulp modules
import gulp from 'gulp';
import clean from 'gulp-clean';
import file from 'gulp-file';
import prompt from 'gulp-prompt';
import run from 'gulp-run';
import sequence from 'gulp-sequence';

// Helpers
import childProcess from 'child_process';
import fs from 'fs';

const BACKUP_DIR = './backup';

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

function wrapHomeDir(filename, excluded = false) {
  return `${excluded ? '!' : ''}${process.env.HOME}/${filename}`;
}

gulp.task('exp', () => {});

gulp.task('backup:cleanup', () => gulp.src(BACKUP_DIR).pipe(clean()));

gulp.task('backup:brew', () => {
  const packages = childProcess.execSync('brew list --versions').toString();

  return gulp.src('!dotfiles')
    .pipe(file('packages', packages))
    .pipe(gulp.dest(`${BACKUP_DIR}/brew`));
});

gulp.task('backup:neovim', () => (
  gulp.src(wrapHomeDir('.config/nvim/init.vim'))
    .pipe(gulp.dest(`${BACKUP_DIR}/neovim`))
));

gulp.task('backup:sublime', () => {
  const packagesPath = wrapHomeDir('Library/Application Support/Sublime Text 3/Packages');
  
  const packages = fs.readdirSync(packagesPath).filter(file =>
    fs.statSync(`${packagesPath}/${file}`).isDirectory() &&
    file !== 'User' // exclude User from packages
  );

  return gulp.src(`${packagesPath}/User/Preferences.sublime-settings`)
    .pipe(file('packages', packages.join('\n')))
    .pipe(gulp.dest(`${BACKUP_DIR}/sublime`));
});

gulp.task('backup:oh-my-zsh', () => {
  const filePaths = [
    wrapHomeDir('.zshrc'),
    wrapHomeDir('.oh-my-zsh/custom/**/*'),
    wrapHomeDir('.oh-my-zsh/**/*example*', true),
  ];

  gulp.src(filePaths)
    .pipe(gulp.dest(`${BACKUP_DIR}/oh-my-zsh`));
});

gulp.task('backup:vscode', () => {
  const command = '/Applications/Visual\\ Studio\\ Code.app/Contents/Resources/app/bin/code';
  const extensions = childProcess.execSync(`${command} --list-extensions`).toString();
  const settings = wrapHomeDir('Library/Application Support/Code/User/settings.json');

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
    'backup:sublime',
    'backup:vscode',
  ],
  'backup:password-prompt'
));
