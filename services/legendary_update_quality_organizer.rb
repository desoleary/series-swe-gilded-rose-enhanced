File.join(File.dirname(__FILE__), 'update_quality_helper')

class LegendaryUpdateQualityOrganizer < ApplicationOrganizer
  def self.call(context)
    ctx = context.merge(params: { min_quality: MIN_LEGENDARY_QUALITY, max_quality: MAX_LEGENDARY_QUALITY })
    with(ctx).reduce([LegendaryUpdateQualityAction, WithinRangeQualityAction, NullUpdateSellInAction])
  end
end
