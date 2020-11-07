Feature: Create a new user for Colgate Marketplace app
  As a user
  so that I can share and see user information,
  I want to be able to create an account for the marketplace.

  Background: the user has not yet been registered
    Given these Users:
      | name | email | password  | payment |
      | ali | a@email.com |  password | venmo |
      | val | vrome@colgate.edu | passyy | cash |

  Scenario: Visit home page without logging in
    Given I am on the items index page, not logged in
    Then I should see "Sign up"
    And I should see "Login"
    But I should not see "Log out"

  Scenario: Create a new user and be automatically logged in
    Given I am on the items index page, not logged in
    Then I should see "Sign up"
    When I press "Sign up"
    Then I should be on the create user page
    When I fill in the following initializers:
      | Field | Value |
      | Name | allegra |
      | payment | venmo |
      | Email | aknox@colgate.edu |
      | Password | password |
      | Password Confirmation | password |

    And I press "Sign up"
    Then I should be on the items index page
    And I should see "Welcome! You have signed up successfully."
    And I should see "Logged in as allegra."
    And I should see "Log out"
    And I should see "Edit profile"
    But I should not see "Login"

#   Scenario: Non-admins shouldn't be allowed on the new toy page
#     Given I am on the new toy page
#     Then I should see "Only admin users can create new toys"
