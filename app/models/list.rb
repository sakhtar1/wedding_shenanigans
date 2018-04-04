class List < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :title, :item
end
