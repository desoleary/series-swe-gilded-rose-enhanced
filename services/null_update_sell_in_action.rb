class NullUpdateSellInAction < ApplicationAction
  promises :sell_in

  executed do |context|
    context.sell_in = context.dig(:input, :sell_in)
  end
end
