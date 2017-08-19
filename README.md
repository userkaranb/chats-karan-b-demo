# Chats-Karan-B

# Overview of Application

This is a very simple chat application that allows 2 users to chat over the internet. It is a rails app that uses postgres as a database. The app uses a very barebones UI mostly as a proof of concept to show that messages are coming in at real time.

# Setup

The app can be brought down and used locally, or accessed at http://chats-karan-b.herokuapp.com/ . I'll explain how to get the environment set up locally ON A MAC, then explain how to use the app.

Clone the repository at https://github.com/userkaranb/chats-karan-b-demo and navigate to the project
```
$ git clone git@github.com:userkaranb/chats-karan-b-demo.git && cd chats-karan-b-demo
```

Install postgres locally
```
$ brew install postgresql
```

Set up rbenv and ruby to run on version 2.4.0
```
$ brew install rbenv
$ rbenv global 2.4.0
```

Install bundler
```
$ gem install bundler
```

Install the rest of the gems and their dependencies using bundler
```
$ bundle install
```

Initialize the local database:
```
$ bin/rake db:create db:migrate
```

Start the app, which should now be accessible at localhost:3000
```
$ rails s
```


# Architecture

# Future Work