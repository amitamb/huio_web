var bz2 = require('unbzip2-stream');
var fs = require('fs')
var output = fs.createWriteStream('output.json')

String.prototype.reverse=function(){return this.split("").reverse().join("");}

var lineReader = require('readline').createInterface({
  input: fs.createReadStream('./input.json')
  // input: fs.createReadStream('./latest-all.json.bz2').pipe(bz2())
});

lineReader.on('line', function (line) {
  // console.log('Line from file:', line);
  if (!line || line.length <= 4) return;
  if ( line.endsWith(",") ) {
    line = line.slice(0, -1);
  }
  var obj = JSON.parse(line);

  if (obj.type == 'item') {
    var name = getName(obj);
    var description = getDescrption(obj);
    var aliases = getAliases(obj);
    var instanceTypes = getInstanceTypes(obj);
    var freebaseId = getFreebaseId(obj);
    var imdbId = getImdbId(obj);
    var netflixId = getNetflixId(obj);
    var enwikiTitle = getEnwikiTitle(obj);

    // episode
    // Q21191270
    // film
    // Q11424

    var outputObj = {
      id: obj.id,
      name,
      description,
      aliases,
      instanceTypes,
      freebaseId,
      imdbId,
      netflixId,
      enwikiTitle
    };

    if ( instanceTypes &&
         (instanceTypes.includes('Q21191270') ||
         instanceTypes.includes('Q11424')) ) {
      output.write(JSON.stringify(outputObj) + "\n");
    }

    // console.log(outputObj);
  }
});

function nullOnException(func, nullValue = null){
  try {
    return func() || null;
  }
  catch(e) {
    return nullValue || null;
  }
}

function getName(obj) {
  return nullOnException(_ => obj.labels.en.value);
}

function getDescrption(obj){
  return nullOnException(_ => obj.descriptions.en.value);
}

function getAliases(obj) {
  return nullOnException(_ => obj.aliases.en.map(_ => _.value));
}

function getInstanceTypes(obj) {
  return nullOnException(_ => obj.claims.P31.
                              map(_ => _.mainsnak.datavalue.value.id));
}

function getFreebaseId(obj) {
  return nullOnException(_ => obj.claims.P646.
                              map(_ => _.mainsnak.datavalue.value)[0]);
}

function getImdbId(obj) {
  return nullOnException(_ => obj.claims.P345.
                              map(_ => _.mainsnak.datavalue.value)[0]);
}

function getNetflixId(obj) {
  return nullOnException(_ => obj.claims.Q4444.
                              map(_ => _.mainsnak.datavalue.value)[0]);
}

function getEnwikiTitle(obj) {
  return nullOnException(_ => obj.sitelinks.enwiki.title);
}
