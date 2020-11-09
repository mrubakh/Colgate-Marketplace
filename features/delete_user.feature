Feature: Delete my marketplace account
  As a user
  so that I can delete my profile when I no longer want to participate,
  I want to be able to delete my account.

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
    And I should see "Delete my account"
    When I press "Delete my account"
    Then I should accept the popup to confirm
    Then I should be on the items index page
    And I should see "Bye! Your account has been successfully cancelled. We hope to see you again soon."
    
    
    
    
    
