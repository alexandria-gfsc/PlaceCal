# frozen_string_literal: true

# app/models/supporter.rb
class Supporter < ApplicationRecord
  has_and_belongs_to_many :sites

  validates_presence_of :name

  default_scope { order(:weight) }
  scope :global, -> { where(is_global: true) }

  mount_uploader :logo, SupporterLogoUploader
end
