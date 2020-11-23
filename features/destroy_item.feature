Feature: Destroy an item on Colgate Marketplace app
    As a user
    so that I can remove sold items or decide not to sell,
    I want to be able to delete the items I am selling.
    
     Background: the user has not yet been registered
        Given these Users:
            | name | email | password  | payment |
            | ali | a@email.com |  password | venmo |
            | val | vrome@colgate.edu | passyy | cash |
        Given these Items:
            | name | description | status  | deliverable | price | category |
            | Book | Good book |  available | yes | 10.99 | Books |
            | Desk | Solid Desk |  available | yes | 109.29 | Furniture |
            | Headphones | These are beats brand |  available | yes | 109.29 | Electronics |
        
    Scenario: Edit an item that I did not list
        Given I am on the items index page
        Then I should see "Book"
        When I press "Book"
        Then I should be on the show item "1" page
        And I should not see "Delete item"
        
    Scenario: Edit an item that I did list
        #make an item
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
        
        #show
        Then I should be on the items index page
        And I should see "gold spoon"
        When I press "gold spoon"
        Then I should be on the show item "4" page
        And I should see "Delete item"
        
        
        When I press "Delete item"
        #press ok on popup isn't implemented yet
        And I press ok
        Then I should be on the items index page
        And I should not see "gold spoon"
        