require File.join(File.dirname(__FILE__), 'application_organizer')

class NormalUpdateQualityOrganizer < ApplicationOrganizer
  def self.call(context)
    ctx = context.merge(params: { min_quality: MIN_QUALITY, max_quality: MAX_QUALITY })
    with(ctx).reduce([NormalUpdateQualityAction, WithinRangeQualityAction, NormalUpdateSellInAction])
  end
end
