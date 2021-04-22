class Stock < ApplicationRecord
  belongs_to :log
  belongs_to :user
end
