class Portfolio
  # Takes symbols or strings as arguments and downcases them, converting them to symbols.
  def initialize(*channel_subscriptions)
    @channel_subscriptions = channel_subscriptions.map {|cs| cs.downcase.to_sym}
  end

  # Returns an array of channels as lowercase symbols
  def channels
    @channel_subscriptions
  end
end
