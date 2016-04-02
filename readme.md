#Lending Owl
[![Stories in Progress](https://badge.waffle.io/weilandia/lending_owl.png?label=Ready)](http://waffle.io/weilandia/lending_owl.io) &nbsp;&nbsp;&nbsp;&nbsp;

LendingOwl is a peer-to-peer micro lending app built as a pivot from a coffee ecommerce app.  The goal of the project was to up the stakes on an agile development workflow by pivoting an entire app in 2 weeks, while adding multiple layers of new permissions. Production is hosted [here](http://lendingowl.herokuapp.com).

Admin Username: admin@lendingowl.com

Admin Password: password


 ![admin workflow](app/assets/images/lending_owl.gif)


###Goals
#####Agile TDD
A main focus for this project was to mock a two week sprint on an agile team with a focus on test-driven-development. We used [waffle.io](https://waffle.io/) to manage issues and pull requests and we used [simplecov](https://github.com/colszowka/simplecov) to monitor test coverage.


####Technical Overview
* Full stack ruby-on-rails
* jQuery
* SendGrid API
* Stripe API
* Amazon Web Services S3 API
* Paperclip
* Testing with rspec and Capybara

### Testing
All testing in Lending Owl was done via [RSpec-rails](https://github.com/rspec/rspec-rails).  We used [shoulda matchers](https://github.com/thoughtbot/shoulda-matchers) to test database validations and relationships.  Our coverage was tested using [simplecov](https://github.com/colszowka/simplecov).
##### Running tests
Once you have the repo cloned, make sure to reset the database on your local machine and bundle.

In order to run the tests, enter `rspec` in the command line.

If you would like to run a specific test enter, the whole path of that test, preceeded by the rspec command: ie.

```
rspec spec/features/user/user_adds_project_to_cart_spec.rb
```

In order to see coverage for our testing suite simply type the command `open coverage/index.html` and it will show the index page for our simple cov code coverage.

Happy testing!
