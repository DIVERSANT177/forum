class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_many :attachments, as: :attachmentable
  has_many :like

  validates :title, :body, presence: true

  accepts_nested_attributes_for :attachments
end
