var chai = require('chai'),
    filetree = require('../..');

var should = chai.should();

// this is a great place to initialize chai plugins
// http://chaijs.com/plugins

global.filetree = filetree;
global.should = should;
