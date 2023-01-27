require File.join(File.dirname(__FILE__), 'application_action')

class WellAgedUpdateQualityAction < ApplicationAction
  promises :quality

  executed do |context|
    quality = context.dig(:input, :quality)
    context.quality = quality + 1
  end
end
