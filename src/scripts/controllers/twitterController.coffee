angular.module('app').controller 'twitterController', ['$log', '$scope', '$rootScope', '$location', 'twitterService', 'jquery', ($log, $scope, $rootScope, $location, twitterService, $) ->
	jqueryVersion = $().jquery

	$('h1').html "jQuery #{jqueryVersion} loaded!"

	$scope.search = (searchTerm) ->
		$location.path "/twitter/#{searchTerm}"

	$scope.onRouteChange = (routeParams) ->
		$scope.searchTerm = routeParams.searchTerm

		twitterService.get $scope.searchTerm
		, (tweets) ->
			$scope.tweets = tweets
]