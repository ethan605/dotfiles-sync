import tap from 'gulp-tap';

tap(file => {
  file.contents = Buffer.concat([new Buffer('HEADER'), file.contents as Buffer]);
});

tap((file, utils) => {
  console.debug(file.cwd, utils.through);
});
