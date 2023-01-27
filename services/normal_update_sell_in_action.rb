class NormalUpdateSellInAction < ApplicationAction
  promises :sell_in

  executed do |context|
    sell_in = context.dig(:input, :sell_in)
    context.sell_in = sell_in - 1
  end
end
