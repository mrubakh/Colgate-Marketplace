class Item < ApplicationRecord
    belongs_to :user
    has_one_attached :image
    
    validates :name, :presence => true
    validates :price, :presence => true, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }, numericality: { greater_than: 0, less_than: 1000000 }
    validates :description, :presence => true, length: {maximum: 100}
    validates :image, allow_blank: true, blob: { content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif'] }
    #size_range: 1..3.megabytes
    def self.search(query)
        Item.all.where("lower(name) LIKE ? OR lower(category) LIKE ? OR lower(description) LIKE ?","%"+query+"%","%"+query+"%","%"+query+"%")
    end
end
