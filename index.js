/**
 * Module dependencies
 */

var kit = require('poe-ui-kit');

/**
 * Expose the app
 */

exports = module.exports = function(opts) {
  opts = opts || {};

  // create an app
  var app = kit(opts);

  // remove the middleware we don't need
  app.remove('methodOverride');
  app.remove('json');
  app.remove('urlencoded');

  app.get('/', function(req, res) {
    res.render('index', function(err, body) {
      if (!err) return res.send(body);
      res.send(204);
    });
  });

  app.get('/((\\d{3}))', function(req, res) {
    var status = req.params[0];
    res.render(status, function(err, body) {
      if (!err) return res.send(body);
      if (status.indexOf('4') === 0) return res.render('4xx');
      res.render('5xx');
    });
  });

  return app;
};

/**
 * Expose the middleware
 */
exports.middleware = kit.middleware;
