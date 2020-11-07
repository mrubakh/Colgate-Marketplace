Feature: Edit existing user for Colgate Marketplace app
  As a user
  so that I can correct or update my profile,
  I want to be able to edit my account information.

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
    When I press "Edit profile"
    Then I should be on the edit profile page
    And I should see "Edit profile"
    When I edit my name and re-enter my password
    | Field | Value |
      | name | Allegra Knox |
      | password | password |
    And I press "Update"
    Then I should be on the items index page
    And I should see "Your account has been updated successfully."
    And I should see "Logged in as Allegra Knox."
