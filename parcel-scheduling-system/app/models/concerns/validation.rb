# frozen_string_literal: true

# Validation
module Validation
  def validate_source_and_destination
    return unless source == destination

    errors.add(:base, "source and destination can't be same.")
  end
end
