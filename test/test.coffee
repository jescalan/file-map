path = require 'path'
_    = require 'lodash'

describe 'basic', ->

  before (cb) ->
    file_map(path.join(test_dir, 'basic'))
      .tap (res) => @map = res
      .then(-> cb())

  it 'should return an array of 2 items', ->
    @map.should.be.an('array')
    @map.should.have.lengthOf(2)

  it 'directories should have the correct keys', ->
    dir = _.find(@map, path: 'some_folder')
    dir.type.should.equal('directory')
    dir.path.should.equal('some_folder')
    dir.full_path.should.be.a('string')
    dir.stat.should.be.an('object')
    dir.children.should.be.an('array')

  it 'files should have the correct keys', ->
    file = _.find(@map, path: 'wow.txt')
    file.type.should.equal('file')
    file.path.should.equal('wow.txt')
    file.full_path.should.be.a('string')
    file.stat.should.be.an('object')

  it 'directory should have 2 children', ->
    dir = _.find(@map, path: 'some_folder')
    dir.children.should.have.lengthOf(2)

  it 'directory children should be correct', ->
    dir = _.find(@map, path: 'some_folder')
    file = _.find(dir.children, path: 'some_folder/foo.txt')
    dir2 = _.find(dir.children, path: 'some_folder/nested')
    should.exist(file, 'foo.txt')
    should.exist(dir2, 'nested')

  it 'deep nested children should be correct', ->
    dir = _.find(@map, path: 'some_folder')
    dir2 = _.find(dir.children, path: 'some_folder/nested')
    dir2.children.should.have.lengthOf(1)
    dir2.children[0].path.should.equal('some_folder/nested/bar.txt')
