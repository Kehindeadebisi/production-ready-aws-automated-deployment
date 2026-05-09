const http = require('http');
const assert = require('assert');
const app = require('./server');

const server = app.listen(0, () => {
  const port = server.address().port;
  const request = http.request(
    {
      hostname: '127.0.0.1',
      port,
      path: '/',
      method: 'GET',
    },
    (res) => {
      let body = '';

      res.on('data', (chunk) => {
        body += chunk;
      });

      res.on('end', () => {
        assert.strictEqual(res.statusCode, 200);
        assert.ok(body.includes('Hello World from DevOps Challenge App!'));
        server.close(() => {
          console.log('App test passed.');
        });
      });
    }
  );

  request.on('error', (err) => {
    server.close(() => {
      throw err;
    });
  });

  request.end();
});