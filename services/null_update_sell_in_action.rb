File.join(File.dirname(__FILE__), 'update_quality_helper')

class NullUpdateSellInAction < ApplicationAction
  promises :sell_in

  executed do |context|
    context.sell_in = context.dig(:input, :sell_in)
  end
end
