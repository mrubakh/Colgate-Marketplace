Feature: List item for sale on Colgate Marketplace app
    As a user
    so that I can sell an item,
    I want to be able to list an item for sale.

    Scenario: List an item for sale without logging in
        Given I am on the items index page
        Then I should not see "List an item"
    
    Scenario: List an item for sale as a logged in user
        Given I am logged in
        Then I should see "List an item"
        When I press "List an item"
        Then I should be on the new item page
        When I fill in the following:
          | Field | Value |
          | Name | gold spoon |
          | Description | for eating in style |
          | Price | 99.99 |
        
        And I press "Save Changes"
        Then I should be on the items index page
        And I should see "gold spoon"
        
    Scenario: Attempt to list an invalid item for sale as a logged in user
        Given I am logged in
        Then I should see "List an item"
        When I press "List an item"
        Then I should be on the new item page
        When I fill in the following:
          | Field | Value |
          | Description | for eating in style |
          | Price | 99.99 |
        
        And I press "Save Changes"
        Then I should be on the new item page
        And I should see "Error creating new product"
        
      
  