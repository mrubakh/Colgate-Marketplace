class Item < ApplicationRecord
    enum category: {:Books => 0, :Electronics => 1, :Furniture => 2}
    
    belongs_to :user
    has_many :favorited_by, through: :favorites, source: :user
    has_one_attached :image
    
    validates :name, :presence => true
    validates :price, :presence => true, format: { with: /\A\d+(?:\.\d{0,2})?\z/ }, numericality: { greater_than: 0, less_than: 1000000 }
    validates :description, :presence => true, length: {maximum: 100}
    validate :image_type
    #size_range: 1..3.megabytes
    def self.search(query)
        Item.all.where("lower(name) LIKE ? OR category = ? OR lower(description) LIKE ?","%"+query+"%",Item.categories[query.capitalize],"%"+query+"%")
    end
    
    private 
    def image_type
      return unless image.attached?
      if !image.content_type.in?(%('image/jpeg image/png 'image/gif))
          errors.add(:image, "needs to be a jpeg or png!")
      end
    end
end
