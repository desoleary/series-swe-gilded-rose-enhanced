require File.join(File.dirname(__FILE__), 'application_organizer')

class BackstageUpdateQualityOrganizer < ApplicationOrganizer
  def self.call(context)
    ctx = context.merge(params: { min_quality: MIN_QUALITY, max_quality: MAX_QUALITY })
    with(ctx).reduce([WellAgedUpdateQualityAction, BackstageUpdateQualityAction, WithinRangeQualityAction, NormalUpdateSellInAction])
  end
end
