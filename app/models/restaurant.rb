class Restaurant < ActiveRecord::Base
	mount_uploader :image, ImageUploader

	searchkick

	has_many :reviews, as: :reviewable, dependent: :destroy

	validates :name, :address, :phone, :email, presence: true
end
