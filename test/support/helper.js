var chai = require('chai'),
    file_map = require('../..'),
    path = require('path'),
    chai_promise = require('chai-as-promised');

var should = chai.should();
chai.use(chai_promise);

global.file_map = file_map;
global.should = should;
global.test_dir = path.join(__dirname, '../fixtures')
