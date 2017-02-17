// Gulp modules
const gulp = require('gulp');
const clean = require('gulp-clean');
const file = require('gulp-file');
const prompt = require('gulp-prompt');
const run = require('gulp-run');
const sequence = require('gulp-sequence');

// Helpers
const childProcess = require('child_process');
const fs = require('fs');

const DEST_DIR = './backup';

const wrapHomeDir = filename => `${process.env.HOME}/${filename}`;

gulp.task('exp', () => {});

gulp.task('backup:brew', () => {
  const packages = childProcess.execSync('brew list --versions').toString();

  return gulp.src('!dotfiles')
    .pipe(file('packages', packages))
    .pipe(gulp.dest(`${DEST_DIR}/brew`));
});

gulp.task('backup:clean', () => gulp.src(DEST_DIR).pipe(clean()));

gulp.task('backup:ssh', () => {
  const sshPath = wrapHomeDir('.ssh/*');

  gulp.src(sshPath)
    .pipe(gulp.dest(`${DEST_DIR}/ssh`))
    .pipe(prompt.prompt({
      type: 'password',
      name: 'password',
      message: 'Enter password for SSH configs zip file',
    }, ({ password }) => (
      gulp.src(`${DEST_DIR}/ssh`)
        .pipe(run(
          `cd ${DEST_DIR} && \
          zip -P ${password} -0r ssh.zip ssh && \
          rm -rf ssh`,
          { silent: true, verbosity: 0 }
        ))
    )));
});

gulp.task('backup:sublime', () => {
  const packagesPath = wrapHomeDir('Library/Application Support/Sublime Text 3/Packages');
  
  const packages = fs.readdirSync(packagesPath).filter(file =>
    fs.statSync(`${packagesPath}/${file}`).isDirectory() &&
    file !== 'User' // exclude User from packages
  );

  return gulp.src(`${packagesPath}/User/Preferences.sublime-settings`)
    .pipe(file('packages', packages.join('\n')))
    .pipe(gulp.dest(`${DEST_DIR}/sublime`));
});

gulp.task('backup:oh-my-zsh', () => {
  const filePaths = [
    '.zshrc',
    '.oh-my-zsh/custom/**/*',
  ].map(wrapHomeDir);

  gulp.src(filePaths)
    .pipe(gulp.dest(`${DEST_DIR}/oh-my-zsh`));
});

gulp.task('backup:vscode', () => {
  const command = '/Applications/Visual\\ Studio\\ Code.app/Contents/Resources/app/bin/code';
  const extensions = childProcess.execSync(`${command} --list-extensions`).toString();
  const settings = wrapHomeDir('Library/Application Support/Code/User/settings.json');

  return gulp.src(settings)
    .pipe(file('extensions', extensions))
    .pipe(gulp.dest(`${DEST_DIR}/vscode`));
});

gulp.task('backup', sequence(
  'backup:clean',
  'backup:brew',
  'backup:oh-my-zsh',
  'backup:sublime',
  'backup:vscode',
  'backup:ssh',
));
