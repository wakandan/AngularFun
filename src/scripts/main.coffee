###global define, require###

requirejs
	map:
		'*':
			'libs/angularResource': 'libs/angular-resource'
			'libs/modal': 'libs/bootstrap-modal'
	shim:
		'libs/angular':
			exports: 'angular'
			deps: [
				'libs/jquery'
			]
		'libs/angular-resource':
			deps: [
				'libs/angular'
			]
		'libs/modal':
			deps: [
				'libs/jquery'
			]
		'libs/jquery':
			exports: '$'
	[
		'app'
		'bootstrap'
		'controllers/gitHubController'
		'controllers/personController'
		'controllers/personDetailsController'
		'controllers/searchHistoryController'
		'controllers/twitterController'
		'directives/modal'
		'directives/ngController'
		'directives/tab'
		'directives/tabs'
		'filters/twitterfy'
		'responseInterceptors/dispatcher'
	], (app) ->
		app.config ['$routeProvider', ($routeProvider) ->
			$routeProvider
			.when '/github/:searchTerm'
				controller: 'gitHubController'
				reloadOnSearch: true
				resolve:
					changeTab: ['$rootScope', ($rootScope) ->
						$rootScope.$broadcast 'changeTab#gitHub'
					]
			.when '/people/:id'
				controller: 'personDetailsController'
				reloadOnSearch: true
				resolve:
					changeTab: ['$rootScope', ($rootScope) ->
						$rootScope.$broadcast 'changeTab#people'
					]
			.when '/twitter/:searchTerm'
				controller: 'twitterController'
				reloadOnSearch: true
				resolve:
					changeTab: ['$rootScope', ($rootScope) ->
						$rootScope.$broadcast 'changeTab#twitter'
					]
			.otherwise
				redirectTo: '/github/CaryLandholt'
		]

		app.run ['$rootScope', '$log', ($rootScope, $log) ->
			$rootScope.$on 'error:unauthorized', (event, response) ->
				#$log.error 'unauthorized'

			$rootScope.$on 'error:forbidden', (event, response) ->
				#$log.error 'forbidden'

			$rootScope.$on 'error:403', (event, response) ->
				#$log.error '403'

			$rootScope.$on 'success:ok', (event, response) ->
				#$log.info 'success'

			# fire an event related to the current route
			$rootScope.$on '$routeChangeSuccess', (event, currentRoute, priorRoute) ->
				$rootScope.$broadcast "#{currentRoute.controller}$routeChangeSuccess", currentRoute, priorRoute
		]