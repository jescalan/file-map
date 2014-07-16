W    = require 'when'
node = require 'when/node'
fs   = node.liftAll(require('fs'))
path = require 'path'
mm   = require 'minimatch'
compact = require('lodash.compact')

root = null

module.exports = file_map = (dir, opts = {}) ->
  dir = path.resolve(dir)

  root ?= dir
  file_ignores = compact(Array::concat(opts.file_ignores))
  dir_ignores = compact(Array::concat(opts.directory_ignores))

  fs.readdir(dir).then (files) ->
    W.map files, (f) ->
      full_path = path.join(dir, f)
      fs.stat(full_path).then (stat) ->
        if stat.isDirectory()
          rel = relative(full_path)
          for ignore in dir_ignores
            if mm(rel, ignore) then return false

          file_map(full_path, opts).then (res) ->
            type: 'directory'
            path: rel
            full_path: full_path
            stat: stat
            children: res
        else
          rel = relative(full_path)
          for ignore in file_ignores
            if mm(rel, ignore) then return false

          type: 'file'
          path: rel
          full_path: full_path
          stat: stat
    .then(compact)

relative = (full_path) ->
  full_path.replace(root + path.sep, '')
