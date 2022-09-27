# README

###  Ruby and Rails Version
we are using ruby 3.1.3 and Rails 7.0.4

### Installation
run `rake db:setup` for creating database, loading schema and importing seed data

### Running tests
run `rspec` to run the tests.

### Scheduler
Scheduler is defined in `config/initializers/scheduler.rb`

### API
GET endpoint to query generated disbursements is:

- `http://localhost:3000/api/v1/disbursements`

available arguments are `year`, `week` and `merchant_id`(optional)

### Suggestion to improve

- The logic of getting the dibursement_period on GenerateDisbursementService is hard coded at the moment. If we need to support scenario where we want to generate disbursements monthly, then we might want to movie this logic outside of the service class and make it possible to define different rule for different merchants dynamically.

- We mignt need more validation and error handling on DisbursementFeeRule.

- I prefer to document code using YARD. Ideally I would have done documentation.

- Would prefer to have a Github Action or something similar for reporting ruboop warnings and test status.