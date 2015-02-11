# Reward Service

An implementation of the following user story in ruby.

````
As a customer, if I am eligible for rewards, then I want to see which rewards are available based on my channel subscriptions.
````

## Some Observations

On a real-life project, I'd expect to have access to a product owner or customer during the definition of acceptance criteria. On reading the defined criteria, a few questions jump out:

1. What sort of "service" should this be? Should it be built as a web service, a set of ruby classes or something else?
2. In what format should the data be passed about?
3. What format should the RewardsService class return?
3. How should an account number be formatted?
4. What is the interface of the EligibilityService?

## Plain Ruby Implementation

This is in `/ruby` and is implemented as a series of ruby classes.

To run the tests:

````
$ cd ruby
$ rspec
````

### Assumptions

1. The account number is a string.
2. The RewardService will only provide a message if there is one to show, but will always return a hash containing a rewards key:

````ruby
{
    message: "Some message",
    rewards: ['CHAMPIONS_LEAGUE_FINAL_TICKET', 'KARAOKE_PRO_MICROPHONE']
}
````

3. `EligibilityService` lives within a `CustomerStatus` module, is instansiated with an account_number and responds to `eligibility()` with the appropriate code, or raises exception. It will only raise a InvalidAccountNumber exception when `eligibility()` is called, not when it's created.

## Example Sinatra Web Service

The `/sinatra` directory contains a very simple example showing how we might expose the RewardService as a JSON web service.

To run the tests:

````
$ cd sinatra
$ rspec
````

To try out the web service:

````
cd sinatra
rackup
````

Send a GET request to http://localhost:9292?account_number=123&portfolio=sports,kids,movies

### Notes on the Sinatra Example
1. It expects the portfolio parameter to be a comma-seperated list of channels. It does not perform validation on this.
2. It expects the account_number parameter to have a value.
3. It uses a MockEligibilityService that always returns `CUSTOMER_ELIGIBLE`. The tests rely on this, which isn't exactly elegant.





