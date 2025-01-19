# frozen_string_literal: true

class Task < ApplicationRecord
  STATUSES = %i[new in_progress completed].freeze
  USERS = %w[Petrov Sidorov Ivanov].freeze
  validates :name, presence: true
  validates :status, presence: true
  validates :creator, presence: true
  validates :completed, presence: true
end