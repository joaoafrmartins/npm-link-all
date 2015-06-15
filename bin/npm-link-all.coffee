#!/usr/bin/env coffee

require 'shelljs/global'

minimist = require 'minimist'

{ resolve } = require 'path'

args = minimist process.argv.slice 2

{ username, src, dest, package: pkg } = args

console.log "link all dependencies in package.json or link all npm modules in a folder"

process.exit 0

src = resolve src

dest = resolve dest

[ "username", "src", "dest" ].map (arg) =>

  if typeof args[arg] is "undefined" then throw new Error "argument #{arg} is undefined"

regexp = new RegExp "\\/#{username}\\/"

oldpwd = process.env.PWD

cd src

repos = ls src

###

ls(src).map (folder) ->

  srcPath = resolve "#{src}/#{folder}"

  pkg = "#{folder}/package"

  try

    pkg = require pkg

    destPath = resolve "#{dest}/#{folder}"

    console.log pkg.repository

    if (pkg?.repository?.url or "").match(regexp) isnt null

      console.log url

    ln "-s", srcPath, destPath

    console.log pkg

  catch err

###

console.log src, repos

cd oldpwd
