require 'rails_helper'

RSpec.describe CnabFile, type: :model do
  describe '#update_status_to_processing' do
    let(:cnab_file) { FactoryBot.create(:cnab_file) }

    it 'updates status to processing' do
      expect { cnab_file.update_status_to_processing }
        .to change { cnab_file.reload.status }
        .from("imported")
        .to("processing")
    end
  end
end
