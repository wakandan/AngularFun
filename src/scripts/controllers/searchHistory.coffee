###global define###

define ['controllers/controllers', 'libs/socket.io', 'services/message'], (controllers, io) ->
	'use strict'

	socket = io.connect '/'

	controllers.controller 'searchHistory', ['$scope', 'message', ($scope, service) ->
		$scope.searchHistory = []

		service.subscribe 'search', (name, parameters) ->
			$scope.searchHistory.push parameters

			socket.emit 'search',
				parameters

		socket.on 'searched', (data) ->
			$scope.$apply ->
				$scope.searchHistory.push data
	]