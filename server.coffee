###global require, __dirname, process###

((express, dir, port = 3005) ->
	dir += '/dist'

	nextId = 0

	people = [
		{"id": "#{nextId++}", "name": "Saasha", "age": "5"}
		{"id": "#{nextId++}", "name": "Planet", "age": "7"}
	]

	getUrl = ->
		"http://localhost:#{port}"

	isUniqueName = (name) ->
		(name for person in people when person.name is name).length is 0



	app = express()
	http = require 'http'
	server = http.createServer app
	io = require('socket.io').listen server
	server.listen port

	app.configure ->
		app.set 'view options',
			layout: false

		app.use express.bodyParser()
		app.use express.static dir
		app.use app.router

		app.engine '.html', (str, options) ->
			(locals) ->
				str

		app.get '/', (req, res) ->
			res.render "#{dir}/index.html"

		app.get '/people', (req, res) ->
			res.json people

		app.get '/people/details/:id', (req, res) ->
			id = req.params.id
			current = person for person in people when parseInt(person.id, 10) is parseInt(id, 10)

			res.json current

		app.post '/people', (req, res) ->
			name = req.body.name

			message =
				"title": "Duplicate!"
				"message": "#{name} is a duplicate.  Please enter a new name."

			return res.send(message, 403) if not isUniqueName name

			person =
				"id": "#{nextId++}"
				"name": "#{name}"
				"age": "0"

			people.push person
			res.json person

	io.sockets.on 'connection', (socket) ->
		socket.on 'search', (data) ->
			socket.broadcast.emit 'searched', data

		###
		socket.on 'gitHubSearch', (data) ->
			console.log 'gitHubSearch', data
			socket.emit 'gitHubSearch',
				lastGitHubSearch: data
		###
		#socket.on 'gitHubSearch', (data) ->
		#	socket.emit 'lastSearch',
		#		message: data

	###
	app.listen port, ->
		console.log "open your browser to the url below"
		console.log getUrl()
	###

)(require('express'), __dirname, process.argv.splice(2)[0])