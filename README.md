# Reward Service

An implementation of the following user story in ruby.

````
As a customer, if I am eligible for rewards, then I want to see which rewards are available based on my channel subscriptions.
````

## Some Caveats

On a real-life project, I'd expect to have access to a product owner or customer during the definition of acceptance criteria. On reading the defined criteria, a few questions jump out:

1. What sort of "service" should this be? Should it be built as a web service, a set of ruby classes or something else?
2. In what format should the data be passed about?
3. What format should the RewardsService class return?
3. How is an account number formatted?
4. What is the interface of the EligabilityService? It's difficult to mock its behaviour without knowing exactly what interface it should have.

With the above in mind, I've produced two solutions:

## Solution 1 - Plain Ruby

This is in `/ruby` and is implemented as a series of ruby classes.

To run:

````
````

To run the tests:

````
````

### Assumptions

## Solution 2 - Sinatra Web Service

This is in `/sinatra` and is implemented as a sinatra/JSON web service.

To run:

````
````

To run the tests:

````
````

### Assumptions




