# File Map

[![npm](http://img.shields.io/npm/v/file-map.svg?style=flat)](https://badge.fury.io/js/file-map) [![tests](http://img.shields.io/travis/jenius/file-map/master.svg?style=flat)](https://travis-ci.org/jenius/file-map) [![coverage](http://img.shields.io/coveralls/jenius/file-map.svg?style=flat)](https://coveralls.io/r/jenius/file-map) [![dependencies](http://img.shields.io/gemnasium/jenius/file-map.svg?style=flat)](https://gemnasium.com/jenius/file-map)

Builds a recursive file tree from a root directory

> **Note:** This project is in early development, and versioning is a little different. [Read this](http://markup.im/#q4_cRZ1Q) for more details.

### Why should you care?

Sometimes, you need to recursively read a directory and get back a flat array of files. Other times, you might want to get back a nested structure so you can walk through the different levels. If you are looking for the former, [readdirp](https://github.com/thlorenz/readdirp) does a remarkable job of this. This library covers the latter case.

### Installation

`npm i file-map`

### Usage

The interface is quite simple, pass it a directory as an argument, and get back a promise with the file map structure. For example:

```js
var file_map = require('file-map');
file_map(__dirname).then(console.log);
```

If you had a directory structure that looked like this, and passed in the `example` folder to file-map:

```
/Users/example
├── some_folder
│   ├── foo.txt
│   └── nested
│       └── bar.txt
└── wow.txt
```

The structure you'll get back will look something like this:

```js
[{
  type: 'directory',
  path: 'some_folder',
  fullPath: '/Users/example/some_folder',
  stat: [Object], // result of fs.stat
  children: [{
    type: 'file',
    path: 'some_folder/foo.txt'
    fullPath: '/Users/example/some_folder/foo.txt',
    stat: [Object]
  }, {
    type: 'directory',
    path: 'some_folder/nested',
    fullPath: '/Users/example/some_folder/nested',
    stat: [Object],
    children: [{
      type: 'file',
      path: 'some_folder/nested/bar.txt'
      fullPath: '/Users/example/some_folder/nested/bar.txt'
      stat: [Object]
    }]
  }]
}, {
  type: 'file',
  path: 'wow.txt'
  fullPath: '/Users/example/wow.txt',
  stat: [Object]
}]
```

So overall, each object contains a `type` (`file` or `directory`), `path` (relative path), `fullPath` (absolute path), and `stat` (fs.stat result). Directories also contain an array of `children`, and utility functions that pull just the `files` or `directories` from the children.

#### Ignores

If there are certain files or folders you want to ignore, you can do this by passing in some additional options.

```js
file_map(__dirname, { ignore_files: 'secret.*', ignore_directories: ['**/wow.txt'] })
```

The `ignore_files` and `ignore_directories` options both take either a string or an array of strings, and they can be [minimatch](https://github.com/isaacs/minimatch) strings. Matches are made against the relative path, so you can include globstars, even though this is a recursive read. So fancy.

#### FAQs

There is no callback interface, because promises are much more flexible, and with such a simple interface, promises don't make it any more complicated anyway. The promise returned is A+ compliant and decorated with extra utilities from [when.js](https://github.com/cujojs/when). There is no sync mode because you shouldn't be doing big i/o reads like this synchronously anyway.

### License & Contributing

- Details on the license [can be found here](LICENSE.md)
- Details on running tests and contributing [can be found here](contributing.md)
