require File.join(File.dirname(__FILE__), 'constants')
Dir.glob('services/**/*.rb').each { |f| require File.join(File.dirname(__FILE__), f) }

class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      name = item.name
      organizer = get_organizer_by_name(item.name)
      ctx = organizer.call(input: { name: name, sell_in: item.sell_in, quality: item.quality })
      item.sell_in = ctx[:sell_in]
      item.quality = ctx[:quality]
    end
  end

  def get_organizer_by_name(name)
    return ConjuredUpdateQualityOrganizer if CONJURED_ITEMS.include?(name)
    return LegendaryUpdateQualityOrganizer if LEGENDARY_ITEMS.include?(name)
    return WellAgedUpdateQualityOrganizer if name == AGED_BRIE
    return BackstageUpdateQualityOrganizer if name == BACKSTAGE_PASSES

    NormalUpdateQualityOrganizer
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
