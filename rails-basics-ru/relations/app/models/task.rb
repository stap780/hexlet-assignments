# frozen_string_literal: true

# Task < ApplicationRecord
class Task < ApplicationRecord
  belongs_to :user
  belongs_to :status
end
