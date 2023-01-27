require File.join(File.dirname(__FILE__), 'gilded_road_enhanced')

shared_examples :gilded_rose_item_after_two_days do |name:, sell_in:, quality:, expected_sell_in:, expected_quality:|
  let(:item) { Item.new(name, sell_in, quality) }
  let(:instance) { described_class.new([item]) }

  subject { instance.update_quality; instance.update_quality[0] }

  it "#{name} with sell_in: #{sell_in} and quantity: #{quality} returns corrected quality" do
    expect(subject.quality).to eql(expected_quality), "expected item quality '#{expected_quality}', got: '#{subject.quality}'"
    expect(subject.sell_in).to eql(expected_sell_in), "expected item sell_in '#{expected_sell_in}', got: '#{subject.sell_in}'"
  end
end

describe GildedRoadEnhanced do
  it_behaves_like :gilded_rose_item_after_two_days, name: "+5 Dexterity Vest", sell_in: 10, quality: 20, expected_sell_in: 8, expected_quality: 18
  it_behaves_like :gilded_rose_item_after_two_days, name: "Elixir of the Mongoose", sell_in: 5, quality: 7, expected_sell_in: 3, expected_quality: 5
  it_behaves_like :gilded_rose_item_after_two_days, name: "Sulfuras, Hand of Ragnaros", sell_in: 0, quality: 80, expected_sell_in: 0, expected_quality: 80
  it_behaves_like :gilded_rose_item_after_two_days, name: "Sulfuras, Hand of Ragnaros", sell_in: -1, quality: 80, expected_sell_in: -1, expected_quality: 80
  it_behaves_like :gilded_rose_item_after_two_days, name: "Aged Brie", sell_in: 2, quality: 0, expected_sell_in: 0, expected_quality: 2
  it_behaves_like :gilded_rose_item_after_two_days, name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 15, quality: 20, expected_sell_in: 13, expected_quality: 22
  it_behaves_like :gilded_rose_item_after_two_days, name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 10, quality: 49, expected_sell_in: 8, expected_quality: 50
  it_behaves_like :gilded_rose_item_after_two_days, name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 5, quality: 49, expected_sell_in: 3, expected_quality: 50
  it_behaves_like :gilded_rose_item_after_two_days, name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 2, quality: 20, expected_sell_in: 0, expected_quality: 26
  it_behaves_like :gilded_rose_item_after_two_days, name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 0, quality: 20, expected_sell_in: -2, expected_quality: 0
  it_behaves_like :gilded_rose_item_after_two_days, name: "Conjured Mana Cake", sell_in: 3, quality: 6, expected_sell_in: 1, expected_quality: 2
end
