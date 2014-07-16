W    = require 'when'
node = require 'when/node'
fs   = node.liftAll(require('fs'))
path = require 'path'

base_root = null

module.exports = file_map = (root) ->
  base_root ?= root
  root = path.resolve(root)

  fs.readdir(root).then (files) ->
    W.map files, (f) ->
      full_path = path.join(root, f)
      fs.stat(full_path).then (stat) ->
        if stat.isDirectory()
          file_map(full_path).then (res) ->
            type: 'directory'
            path: relative(full_path)
            full_path: full_path
            stat: stat
            children: res
        else
          type: 'file'
          path: relative(full_path)
          full_path: full_path
          stat: stat

relative = (full_path) ->
  full_path.replace(base_root + path.sep, '')
