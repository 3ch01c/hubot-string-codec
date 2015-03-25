'use strict'

gulp = require 'gulp'
$ = (require 'gulp-load-plugins') lazy: false
del = require 'del'
es = require 'event-stream'

paths =
  lint: [
    './gulpfile.coffee'
    './src/**/*.coffee'
  ]
  watch: [
    './gulpfile.coffee'
    './src/**/*.coffee'
    './test/**/*.coffee'
    '!test/{temp,temp/**}'
  ]
  tests: [
    './test/**/*.coffee'
    '!test/{temp,temp/**}'
  ]
  source: [
    './src/**/*.coffee'
  ]
  libs: [
    './lib/**/*'
  ]


gulp.task 'lint', ->
  gulp.src paths.lint
    .pipe $.coffeelint('./coffeelint.json')
    .pipe $.coffeelint.reporter()

gulp.task 'clean', del.bind(null, ['./compile'])

gulp.task 'compile', ['lint'], ->
  es.merge(
    gulp.src paths.source
      .pipe $.sourcemaps.init()
      .pipe($.coffee(bare: true).on('error', $.util.log))
      .pipe $.sourcemaps.write()
      .pipe gulp.dest('./compile/src')
    gulp.src paths.libs
      .pipe gulp.dest('./compile/lib')
    gulp.src paths.tests
      .pipe $.sourcemaps.init()
      .pipe($.coffee(bare: true).on('error', $.util.log))
      .pipe $.sourcemaps.write()
      .pipe $.espower()
      .pipe gulp.dest('./compile/test')
  )

gulp.task 'test', ['compile'], ->
  gulp.src ['./compile/test/*.js'], {cwd: __dirname}
    .pipe $.mocha()

gulp.task 'watch', ['test'], ->
  gulp.watch paths.watch, ['test']

gulp.task 'default', ['test']
