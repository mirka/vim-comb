var findUp = require('find-up');
var Comb = require('csscomb');

// Config
var cssCombFileName = '.csscomb.json';
var defaultConfig = 'yandex';

// Arguments
var syntax = process.argv[2];
var currentFile = process.argv[3];

var comb = initCombInstance();
var contentChunks = [];


process.stdin.setEncoding('utf8');

process.stdin.on('readable', function () {
  var chunk = process.stdin.read();
  contentChunks.push(chunk);
});

process.stdin.on('end', function () {
  comb.processString(contentChunks.join(''), { syntax: syntax })
    .then(function (output) {
      console.log(output);
      process.exit(0);
    })
    .catch(function (err) {
      console.log(err.context + '\n');
      console.log(err.stack);
      process.exit(1);
    });
});

function initCombInstance() {
  var cssCombFile = findUp.sync(cssCombFileName, { cwd: currentFile });
  var config = cssCombFile ? require(cssCombFile) : defaultConfig;
  return new Comb(config);
}
