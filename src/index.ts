import http from 'http';

const server = http.createServer((request, response) => {
    
    const fullUrl = new URL('http://domain.com' + request.url);

    const name = fullUrl.searchParams.get('name');

    if (name) {
        response.write(`Your name is '${name}'!`);
    }
    
    response.end();
});

server.listen(8080);