File.join(File.dirname(__FILE__), 'update_quality_helper')

class WithinRangeQualityAction < ApplicationAction
  expects :quality
  promises :quality

  executed do |context|
    min_quality = context.dig(:params, :min_quality)
    max_quality = context.dig(:params, :max_quality)
    quality = context.dig(:quality)
    context.quality = [[quality, min_quality].max, max_quality].min
  end
end
