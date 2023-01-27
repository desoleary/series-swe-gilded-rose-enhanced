require File.join(File.dirname(__FILE__), 'application_action')

class LegendaryUpdateQualityAction < ApplicationAction
  promises :quality

  executed do |context|
    context.quality = MAX_LEGENDARY_QUALITY
  end
end
