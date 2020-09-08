class CnabService::Parser < ApplicationService
  def initialize(line)
    @line = line
  end

  def call
    Cnab.new(
      transaction_type: parse_transaction_type,
      datetime: parse_datetime,
      value: parse_value,
      document: parse_document,
      card: parse_card,
      owner: parse_owner,
      store: parse_store
    )
  end

  private

  def parse_datetime
    DateTime.parse("#{parse_date} #{parse_time}#{timezone}")
  end

  def parse_transaction_type
    @line[0..0]
  end

  def parse_date
    @line[1..8]
  end

  def parse_value
    @line[9..18].to_f / 100
  end

  def parse_document
    @line[19..29]
  end

  def parse_card
    @line[30..41]
  end

  def parse_time
    @line[42..47]
  end

  def parse_owner
    @line[48..61].strip
  end

  def parse_store
    @line[62..80].strip
  end

  def timezone
    '-03:00'
  end
end
