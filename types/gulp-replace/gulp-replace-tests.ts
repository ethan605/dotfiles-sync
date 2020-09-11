import replace from 'gulp-replace';

// String test, string replace
replace('bar', 'foo');

// Regex test, string replace
replace(/bar/gi, 'bar');

// Regex test, string replace with Regex param `$1`
replace(/foo(.{3})/g, '$1foo');

// String test, function replace
replace('foo', match => match.split('').reverse().join(''));

// Regex test, function replace
replace(/foo(.{3})/g, (match, p1, offset, string) => {
  console.log(`Found ${match} with param ${p1} at ${offset} inside of ${string}`);
  return 'bar' + p1;
});
