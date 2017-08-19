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

# Using the app

At this point, you are able to either run the app locally or at http://chats-karan-b.herokuapp.com/ in heroku. 

You will be on the home page, and will see a box for "Username" and "Friend". If this is your first time using the app, and a user doesnt exist, you should register in the box below. This will create an entry in the database. For a chat to begin, it requires that a user and a friend are already "registered". So if you were to talk to your friend, have your friend register with her username, and you should simultaneously, on your computer, register your username. Keep in mind, you and your friend should be pointed to the same database, meaning if you run this locally, you can only really talk to yourself. If you are on heroku, you can have a friend on her own computer create her own username.

Once the usernames are both created, enter your name, and enter your friend. Your friend can do the same (entering her name as the username and your username as the friend), and you will be directed to the chat room.

You should be able to send messages and see them appear in real time. 

# Architecture

The technology decision was to go with a rails app using postgres, because to me, this would be the quickest way to get a functional chat app running. I love bundler and how rails makes package management so easy. The way I designed it was to have each new message between two people sent as a post route from the sender, and the contents of the message are saved in the database. 

Each Message row in the Message table has a user_id (which corresponds to the user who sent it), a field to_id, which corresponds to the user who received the message, a body field containing the string content of the message, and timestamps. 

The only other table is the Users table, each user has an id and a username, and has_many messages, linked by the id field in the users table and the user_id field in the messages table.

On the browser, your id, your username, your friends username, and your friends id are all cached in the session variable. As it sounds, these attributes will be available globally for the duration of the session. If you were to talk to yourself, locally, for example, you would want to open two browsers: 1 regular, and 1 incognito, to create 2 sessions. 

Additionally, there is a javascript function that runs every second, polling for new messages. It serializes the response every second and renders it to a div in the chatroom screen.

# Testing

To test this locally, you can run rspec to run the test suite. From the root directory of the project, just run

```
$ rspec
```

There is test coverage for all services, controllers, and models.

# Future Work

There are a few things that can definitely be done to enhance this app.

The first thing I would like to highlight is the UI. Since the UI was not a part of this assignment, it isn't that great. I just tried to make something work, which it seems to do, but would want to make enhancements, such as adding an authentication page, making the outbound and inbound messages different colours, and have a more useful timestamp. Adding some colour and style to each of those pages would be something I could expand on given extra time. 

I would also want to move the interaction to Action Cable and leverage a channel to asynchronously send the messages to each other in real time...this would significantly improve the performance and would not require expensive polls every second. I put the app together this way because the data we are sending is small, and our table doesn't have a lot users/message in it. But these queries for messages become more and more expensive as there are more messages.
