File.join(File.dirname(__FILE__), 'update_quality_helper')

class LegendaryUpdateQualityAction < ApplicationAction
  promises :quality

  executed do |context|
    context.quality = MAX_LEGENDARY_QUALITY
  end
end
