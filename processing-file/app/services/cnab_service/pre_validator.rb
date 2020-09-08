class CnabService::PreValidator < ApplicationService
  CNAB_POSITIONS = 80

  def initialize(line, position)
    @line = line
    @position = position
  end

  def call
    basic_validation
  end

  private

  def basic_validation
    if @line.size != CNAB_POSITIONS
      return ["the line #{@position} must have #{CNAB_POSITIONS} positions, found #{@line.size}"]
    end

    []
  end
end
