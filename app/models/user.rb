class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :listings, :class_name => 'Listing', :foreign_key => 'owner_id'
  has_many :buyer_transactions, :class_name => 'Transaction', :foreign_key => 'buyer_id'
  has_many :seller_transactions, :class_name => 'Transaction', :foreign_key => 'seller_id'
  accepts_nested_attributes_for :listings
end
