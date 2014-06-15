import DS from 'ember-data';

export default DS.Model.extend({
  nameof_filer: DS.attr(),
  date_received: DS.attr('date'),
  date_posted: DS.attr('date'),
  address: DS.attr(),
  view_url: DS.attr(),
  body: DS.attr()
});
