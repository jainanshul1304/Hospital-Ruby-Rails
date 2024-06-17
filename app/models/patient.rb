class Patient < ApplicationRecord
    belongs_to :user
    
    validates :patient_name, presence: true, length: { minimum: 1 }
    scope :count_by_day, -> { group_by_day(:created_at).count }
    
    def self.search(term, per_page, current_page)
      patients = Patient.offset((current_page - 1) * per_page).limit(per_page)
      if term.present?
        # Use ILIKE for case-insensitive search in PostgreSQL
        patients = patients.where("category ILIKE ?", "%#{term}%")
      end
      patients
    end
  end
  