require 'rails_helper'

RSpec.describe CnabFile, type: :model do
  describe '#update_status_to_processing' do
    let(:subject) { FactoryBot.create(:cnab_file, status: :imported) }

    it 'updates status to processing' do
      expect { subject.update_status_to_processing }
        .to change { subject.reload.status }
        .from("imported")
        .to("processing")
    end
  end

  describe '#update_status_to_completed' do
    let(:subject) { FactoryBot.create(:cnab_file, status: :processing) }

    it 'updates status to processing' do
      expect { subject.update_status_to_completed }
        .to change { subject.reload.status }
        .from("processing")
        .to("completed")
    end
  end
end
