import file from 'gulp-file';

// Single source, string content
file('test.txt', 'Test string content');

// Single source, string content, replace gulp.src()
file('test.txt', 'Test string content', { src: true });

// Single source, Buffer content
file('test.txt', new Buffer('Test buffer content'));

// Single source, Buffer content, replace gulp.src()
file('test.txt', new Buffer('Test buffer content'), { src: true });
