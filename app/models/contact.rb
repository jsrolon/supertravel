class Contact < ActiveRecord::Base
  belongs_to :user

  attr_accessible :name, :phone, :description

  validates :name,:phone, :description, :presence => true

end
