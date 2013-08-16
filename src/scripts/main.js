require({
  shim: {
    'controllers/gitHubController': {
      deps: ['app', 'services/gitHubService']
    },
    'controllers/personController': {
      deps: ['app', 'services/personService']
    },
    'controllers/personDetailsController': {
      deps: ['app', 'services/personService']
    },
    'controllers/searchHistoryController': {
      deps: ['app', 'services/messageService']
    },
    'directives/ngController': {
      deps: ['app']
    },
    'directives/tab': {
      deps: ['app']
    },
    'directives/tabs': {
      deps: ['app', 'directives/tab']
    },
    'filters/twitterfy': {
      deps: ['app']
    },
    'angular-resource': {
      deps: ['angular']
    },
    'responseInterceptors/dispatcher': {
      deps: ['app']
    },
    'services/gitHubService': {
      deps: ['app', 'services/messageService']
    },
    'services/messageService': {
      deps: ['app']
    },
    'services/personService': {
      deps: ['app']
    },
    'app': {
      deps: ['angular', 'angular-resource']
    },
    'bootstrap': {
      deps: ['app']
    },
    'routes': {
      deps: ['app']
    },
    'run': {
      deps: ['app']
    },
    'views': {
      deps: ['app']
    }, 
    'angular-strap': ['angular']
  }
}, ['require',
    'controllers/gitHubController',
    'controllers/personController',
    'controllers/personDetailsController',
    'controllers/searchHistoryController',
    'directives/ngController',
    'directives/tabs',
    'filters/twitterfy',
    'responseInterceptors/dispatcher',
    'routes',
    'run',
    'jquery',
    'angular-strap',
    'views'], function(require) {
  return angular.element(document).ready(function() {
    return require(['bootstrap']);
  });
});
