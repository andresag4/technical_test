# Technical Test

This purpose of this test is to develop my skills as developer.
I am going to explain step by step what I was doing and how or why I do it that way.

## Creating the project

When I start a project the first thing I do is to add the ruby version to the Gemfile as well as assigning a new gemset.
This is done by adding this code to the Gemfile:

```
ruby '2.3.0'
#ruby-gemset=test-gemset
```

After that I configure Git. The structure I use is to start in a `master` branch, doing the first commit and pushing 
the branch to the repository. Then I create a second branch called `develop` and push it as well. Every new feature 
that is going to be developed is done in a separate branch that is created from `develop` and when the feature is done, I merge the branch to `develop`.

## Creating the database

I will create a Cart model and a Product scaffold.

| Product      |
|--------------|
| Name: String |
| Tag: String  |
| Price: Float |

| Cart            |
|-----------------|
| product_id: Int |
| quantity: Int   |

The attributes will have some validations that I will test later on.

## Testing models

At this moment I am going to add the Rspec gem in the Gemfile.
I am also adding the gem `shoulda-matchers` which provides more methods for testing and make it easier and faster.

The spec files are located under `/spec/models`. There is a file corresponding to each model in which I test the 
validations, the methods and even associations from each one.

## Style

I added the gems for Bootstrap, ClientSideValidation and Font-awesome.
I changed the style from the views and added some css.
The assets changed where these:
```
/assets/javascripts/*
/assets/stylesheets/*
```

In the cart javascript I added a function that is called when you interact with the cart.
It is basically used to add/remove items. I used AJAX in this method.

In the stylesheets, I mainly edited the `general.css` which has some style for the tables I use.

## Adding the functionality

I added some routes that will help me interact with the cart.

The routes you may use are:

```
/products # Basically the scaffold from products structure
/cart # This is where you interact with the cart, adding/removing items.
```

I also added `i18n`. Every model and view have their respective `i18n` file.

This are located under `/config/locales/*`




## Files edited

```
/app/assets/*
/app/controllers/*
/app/models/*
/app/views/*

/config/locales/*

/spec/models/*

Gemfile
```
