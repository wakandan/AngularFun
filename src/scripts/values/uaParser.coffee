angular.module('app').value 'uaParser', ->
	window.UAParser.call @, arguments[0]