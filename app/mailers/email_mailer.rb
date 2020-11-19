class EmailMailer < ApplicationMailer
    default from: 'colgatemarketplace@gmail.com'
    def interest_email
        @seller = params[:seller]
        @buyer = params[:buyer]
        @item = params[:item]
        mail(to: @seller.email, subject: "#{@buyer.name} is interested in your #{@item.name}")
    end
end
