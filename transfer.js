#!/usr/bin/env node
const path = require('path')
const fs = require('fs')
const os = require('os')
const readline = require('readline')

const targetDir = path.join(__dirname, '/content/posts')

readDir(targetDir, transfer)

function transfer(file) {
	if (file.indexOf('copy') > -1) return
	const copyPath = path.join(targetDir, file.split('.').join('.copy.'))
	const filePath = path.join(targetDir, file)
	const readStream = fs.createReadStream(filePath)
	const writeStream = fs.createWriteStream(copyPath)
	const rl = readline.createInterface({
		input: readStream,
	})
	let active = false
	let categories = []
	rl.on('line', function (line) {
		if (line.indexOf('tags') > -1 && line.indexOf('[') === -1) {
			const [name, value] = line.split(':')
			line = `${name}: ['${value.trim()}']`
			console.log(line)
		}

		if (active) {
			if (line.indexOf('- ') === -1) {
				active = false
				line = 'categories: ' + JSON.stringify(categories) + os.EOL + line
				categories = []
			} else {
				const arr = line.split('-')
				categories.push(arr[arr.length - 1])
				return
			}
		}
		if (line.indexOf('categories') > -1 && line.indexOf('[') === -1) {
			active = true
			return
		}

		writeStream.write(line + os.EOL)
	})
	rl.on('close', function () {
		console.log('rl close')
		writeStream.close()
	})

	writeStream.on('close', function () {
		console.log('writeStream close')
		fs.unlinkSync(filePath)
		fs.renameSync(copyPath, filePath)
	})
}

function readDir(path, callback) {
	fs.readdir(path, function (err, files) {
		console.log(files)
		if (err) {
			return console.error(err)
		}
		files.forEach(function (file) {
			callback(file)
		})
	})
}
