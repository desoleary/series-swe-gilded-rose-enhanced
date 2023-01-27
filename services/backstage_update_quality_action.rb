require File.join(File.dirname(__FILE__), 'application_action')

class BackstageUpdateQualityAction < ApplicationAction
  expects :quality
  promises :quality

  executed do |context|
    sell_in = context.dig(:input, :sell_in)

    case sell_in
      when 6..10
        context.quality = context.quality + 1
      when 0..5 then
        context.quality = context.quality + 2
      when proc { |val| val < 0 } then
        context.quality = 0
      else
        # do nothing
    end
  end
end
