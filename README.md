# Yahoo! Authentication Flow Example With Ruby Webrick Webserver

This tutorial will use Ruby in the Authentication Flow example app for [Yahoo! Apps](https://developer.yahoo.com/oauth2/guide/openid_connect/getting_started.html).

> This flow first gets a code from the Yahoo! Accounts Service, then exchanges that code for an access token. The code-to-token exchange requires a secret key, and for security is done through direct server-to-server communication.
In this example we retrieve data from the Web API /userinfo endpoint, that includes information about the current user.

Here we will use Ruby for server-side applications.

## Installation
First you need to clone the repository.
```
$ git clone https://github.com/azolf/yahoo-web-api-auth-examples-ruby.git
```
Then you should go to the directory and install the required Gems.
```
$ cd yahoo-web-api-auth-examples-ruby/
$ bundle install
```

You could edit the Yahoo! Client Id and Client Secret in `initializers/ruby_oauth.rb` file.
```
RubyOuath.configure do |c|
  c.client_id = ENV['CLIENT_ID']
  c.client_secret = ENV['CLIENT_SECRET']
  c.provider = 'Yahoo!'
end
```

Or you could pass them as environemnt variables.
```
$ CLIENT_ID=YOUR_CLIENT_ID CLIENT_SECRET=YOUR_CLIENT_SECRET ruby server.rb
```

## Using Docker Image
You could also use pre built docker image.

```
$ docker pull azolf/yahoo-web-api-auth-examples-ruby
$ docker run -itd \
--name yahoo-web-api-auth-examples-ruby \
-p 8000:8000 \
-e CLIENT_ID=YOUR_CLIENT_ID \
-e CLIENT_SECRET=YOUR_CLIENT_SECRET \
azolf/yahoo-web-api-auth-examples-ruby:latest
```

## Using docker-compose
You could also clone the repository and start the container with the `docker-compose.yml` file. You just need to replace your Client Id and Client Secret in it.
```
version: '3'
services:
  app:
    image: azolf/yahoo-web-api-auth-examples-ruby
    container_name: yahoo-web-api-auth-examples-ruby
    ports:
      - 8000:8000
    environment:
      - CLIENT_ID=YOUR_CLIENT_ID
      - CLIENT_SECRET=YOUR_CLIENT_SECRET
```

```
$ docker-compose up -d
```

Then, open http://localhost:8000 in a browser.