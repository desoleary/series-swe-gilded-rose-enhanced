File.join(File.dirname(__FILE__), 'update_quality_helper')

class ConjuredUpdateQualityAction < ApplicationAction
  expects :quality
  promises :quality

  executed do |context|
    original_quality = context.dig(:input, :quality)

    quality_delta = [original_quality - context.quality, 0].max
    context.quality = context.quality - quality_delta
  end
end
