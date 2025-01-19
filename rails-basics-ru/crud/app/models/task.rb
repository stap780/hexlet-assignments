# frozen_string_literal: true

class Task < ApplicationRecord
  STATUSES = %i[new finished].freeze
  validates :name, presence: true
  validates :status, presence: true
  validates :creator, presence: true
  validates :completed, inclusion: [true, false]
  
end