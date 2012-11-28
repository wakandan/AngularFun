###global define###

define ['directives/directives', 'libs/jquery', 'libs/modal'], (directives, $) ->
	'use strict'

	directives.directive 'appModal', ['$log', '$timeout', ($log, $timeout) ->
		link = (scope, element, attrs, controller) ->
			#helper so you don't have to type class='modal hide'
			element.addClass 'modal hide'

			element.on 'shown', ->
				element.find('[autofocus]').focus()

			scope.$watch attrs.ngModel, (value) ->
				element.modal value and 'show' or 'hide'

			#If bootstrap animations are enabled, listen to 'shown' and 'hidden' events
			element.on $.support.transition and 'shown' or 'show', ->
				$timeout ->
					controller.$setViewValue true

			element.on $.support.transition and 'hidden' or 'hide', ->
				$timeout ->
					controller.$setViewValue false

		link: link
		require: 'ngModel'
		restrict: 'EAC'
	]