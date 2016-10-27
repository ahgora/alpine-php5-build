Alpine-PHP5-Build
===================


Base docker image to run PHP5 applications on Apache



Building the base image
-----------------------

To create the base image `ahgora/alpine-php5-build`, execute the following command on the tutum-docker-php folder:

      docker build -t ahgora/alpine-php5-build:latest  .


Running your Apache+PHP docker image
------------------------------------

Start your image binding the external ports 80 to your container:

      docker run -t -d -p 80:80 ahgora/alpine-php5-build -DFOREGROUND


Loading your custom PHP application
-----------------------------------

This image can be used as a base image for your PHP application. Create a new `Dockerfile` in your
PHP application folder with the following contents:

    FROM ahgora/alpine-php5-build

After that, build the new `Dockerfile`:

    docker build -t username/my-php-app .

And test it:

    docker run -t -d -p 80:80 username/my-php-app -DFOREGROUND 

Test your deployment:

    curl http://localhost/

That's it!

