class Task < ApplicationRecord
    belongs_to :user
    validates :name, presence: true
    def self.ransackable_attributes(auth_object = nil)
        %w[name created_at]
      end
    def self.ransackable_associations(auth_object = nil)
    []
    end 
end

