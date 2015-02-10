class InvalidAccountNumber < StandardError
  def initialize
    super
  end

  def message
    "Invalid Account Number"
  end
end
