class Item < ApplicationRecord
    belongs_to :user
    has_one_attached :image
    
    validates :name, :presence => true
    validates :price, :presence => true, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }, numericality: { greater_than: 0, less_than: 1000000 }
    validates :description, :presence => true, length: {maximum: 100}
    validates :image, allow_blank: true, format: {
        with: /\.(gif|jpg|png|jpeg)\z/i,
        message: 'must be a url for gif, jpg, jpeg, or png image'
    }
    
    def self.search(query)
        Item.all.where("lower(name) LIKE ? OR lower(category) LIKE ? OR lower(description) LIKE ?","%"+query+"%","%"+query+"%","%"+query+"%")
    end
end
