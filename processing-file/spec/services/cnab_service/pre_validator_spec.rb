require 'rails_helper'

RSpec.describe CnabService::PreValidator do
  describe '#call' do
    it 'returns error when line has less than 81 characters' do
      line = 'x' * 50

      errors = CnabService::PreValidator.(line, 55)

      expect(errors).to eq(["the line 55 must have 81 positions"])
    end
      
    it 'returns error when line has more than 81 characters' do
      line = 'x' * 90

      errors = CnabService::PreValidator.(line, 55)

      expect(errors).to eq(["the line 55 must have 81 positions"])
    end

    it 'does not return error when line has 81 characters' do
      line = 'x' * 81

      errors = CnabService::PreValidator.(line, 55)

      expect(errors.size).to eq(0)
    end
  end
end
