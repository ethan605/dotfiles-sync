// Gulp modules
const gulp = require('gulp');
const clean = require('gulp-clean');
const file = require('gulp-file');
const sequence = require('gulp-sequence');

// Helpers
const childProcess = require('child_process');
const fs = require('fs');

const DEST_DIR = './files';

const wrapHomeDir = filename => `${process.env.HOME}/${filename}`;

gulp.task('tst', () => {
});

gulp.task('backup:clean', () => gulp.src(DEST_DIR).pipe(clean()));

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
  const fileNames = [
    '.zshrc',
    '.oh-my-zsh/custom/**/*',
  ].map(wrapHomeDir);

  gulp.src(fileNames)
    .pipe(gulp.dest(`${DEST_DIR}/oh-my-zsh`));
});

gulp.task('backup:vscode', () => {
  const vscode = '/Applications/Visual\\ Studio\\ Code.app/Contents/Resources/app/bin/code';
  const extensions = childProcess.execSync(`${vscode} --list-extensions`).toString();
  const settings = wrapHomeDir('Library/Application Support/Code/User/settings.json');

  return gulp.src(settings)
    .pipe(file('extensions', extensions))
    .pipe(gulp.dest(`${DEST_DIR}/vscode`));
});

gulp.task('backup', sequence(
  'backup:clean',
  'backup:oh-my-zsh',
  'backup:sublime',
  'backup:vscode',
));
