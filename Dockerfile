FROM node:18

RUN mkdir /var/www

COPY dist/* /var/www

ENTRYPOINT [ "/usr/local/bin/node", "/var/www/index.js" ]