var fs = require('fs');
var Comb = require('csscomb');

var cssCombFile = process.argv[3];
if (fs.existsSync(cssCombFile)) {
  var config = require(cssCombFile);
  var comb = new Comb(config);
} else {
  var comb = new Comb('zen');
}

process.stdin.setEncoding('utf8');

var contentChunks = [];
process.stdin.on('readable', function() {
  var chunk = process.stdin.read();
  contentChunks.push(chunk);
});

process.stdin.on('end', function() {
  var syntax = process.argv[2];
  var output = comb.processString(contentChunks.join(), { syntax: syntax });
  if (output) {
    console.log(output);
    process.exit(0);
  } else {
    process.exit(1);
  }
});
