class FavoriteItem < ApplicationRecord
  belongs_to :item
  belongs_to :user
end
