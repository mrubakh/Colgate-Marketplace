Feature: Create a new user for Colgate Marketplace app
    As a buyer
    So that I can filter products by categories, price, location, preferred mode of payment
    I want to be able to only view the items I am interested in
    
    Background: the user has not yet been registered
        Given these Users:
          | name | email | password  | payment |
          | ali | a@email.com |  password | venmo |
          | val | vrome@colgate.edu | passyy | cash |
        Given these Items:
          | name | description | status  | deliverable | price | 
          | Book | Good book |  available | yes | 10.99 |
          | Desk | Solid Desk |  available | yes | 109.29 |
          
    
    Scenario: Empty Search Bar
      Given I am on the items index page
      Then I should see "Book"
      When I search ""
      Then I should see "Empty Search"
      
    Scenario: Search for existing item
      Given I am on the items index page
      When I search "Book"
      Then I should see "Book"
      And I should not see "Desk"
      
    Scenario: Search for non existing item
      Given I am on the items index page
      When I search "Computer"
      Then I should not see "Book"
      And I should not see "Desk"
    
    