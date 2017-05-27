var fs = require('fs');
var findUp = require('find-up');
var Comb = require('csscomb');

var cssCombFileName = '.csscomb.json';

function getUserHome() {
  return process.env[(process.platform == 'win32') ? 'USERPROFILE' : 'HOME'];
}

var currentFile = process.argv[3];
var cssCombFile = findUp.sync(cssCombFileName, { cwd: currentFile });
var cssCombFileGlobal = getUserHome() + '/' + cssCombFileName;

if (fs.existsSync(cssCombFile)) {
  var config = require(cssCombFile);
  var comb = new Comb(config);
} else if (fs.existsSync(cssCombFileGlobal)) {
  var config = require(cssCombFileGlobal);
  var comb = new Comb(config);
} else {
  var comb = new Comb('yandex');
}

process.stdin.setEncoding('utf8');

var contentChunks = [];
process.stdin.on('readable', function() {
  var chunk = process.stdin.read();
  contentChunks.push(chunk);
});

process.stdin.on('end', function() {
  var syntax = process.argv[2];
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
