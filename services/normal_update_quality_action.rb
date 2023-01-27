require File.join(File.dirname(__FILE__), 'application_action')

class NormalUpdateQualityAction < ApplicationAction
  promises :quality

  executed do |context|
    sell_in = context.dig(:input, :sell_in)
    quality = context.dig(:input, :quality)

    context.quality = sell_in > 0 ? quality - 1 : quality - 2
  end
end
