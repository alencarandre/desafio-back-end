class CnabFile < ApplicationRecord
  extend Enumerize

  has_one_attached :file

  enumerize :status, 
    in: %i(imported processing completed)
  
  validates :file, presence: true
  
  def update_status_to_processing
    update(status: :processing)
  end
end
