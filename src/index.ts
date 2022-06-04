import http from 'http';

const server = http.createServer((request, response) => {

    let data: string = '';
    
    request.on('data', chunk => {
        data += chunk;
    });

    request.on('end', () => {
        const parsedData = JSON.parse(data);
        response.write(`Your name is '${parsedData.name}'!`);
        response.end();
    });

});

server.listen(8080);