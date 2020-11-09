Feature: Log in and log out of marketplace app
  As a user
  so that I can (eventually) have more permissions when I'm logged in,
  I want to be able to access the site both with and without an account.

  Background: the has been registered
    Given these Users:
      | name | email | password  | payment |
      | ali | a@email.com |  password | venmo |
      | val | vrome@colgate.edu | passyy | cash |

  Scenario: log in as existing user
    Given I am on the items index page, not logged in
    Then I should see "Login"
    When I press "Login"
    Then I should be on the sign in page
    When I fill in the following credentials:
      | Field | Value |
      | Email | a@email.com |
      | Password | password |

    And I press "Log in"
    Then I should be on the items index page
    And I should see "Signed in successfully."
    And I should see "Logged in as ali."
    And I should see "Log out"
    And I should see "Edit profile"
    But I should not see "Login"
    When I press "Log out"
    Then I should be on the items index page
    And I should see "Signed out successfully."
    And I should see "Sign up"
    And I should see "Login"




