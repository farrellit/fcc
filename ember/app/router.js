import Ember from 'ember';

var Router = Ember.Router.extend({
  location: FccENV.locationType
});

Router.map(function() {
  this.resource('comments', function() {
    this.route('show', {path: ':comment_id'});
  });
});

export default Router;
