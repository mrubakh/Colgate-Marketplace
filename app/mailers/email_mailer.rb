class EmailMailer < ApplicationMailer
    default from: 'colgatemarketplace@gmail.com'
    def interest_email(seller, buyer, item)
        @seller = seller
        @buyer = buyer
        @item = item
        
        mail(to: @seller.email, subject: "#{@buyer.name} is interested in your #{@item.name}")
    end
end
