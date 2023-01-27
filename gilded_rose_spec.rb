require 'byebug'
require File.join(File.dirname(__FILE__), 'gilded_rose')

Dir.glob('services/**/*.rb').each { |f| require File.join(File.dirname(__FILE__), f) }



describe GildedRose do
  let(:sell_in) { 10 }
  let(:quality) { 10 }
  let(:name) { "foo" }
  let(:item) { Item.new(name, sell_in, quality) }

  describe "#update_quality" do
    subject { GildedRose.new([item]).update_quality[0] }

    context 'with conjured' do
      let(:name) { GildedRose::CONJURED }

      it 'decreases quality 2X' do
        expect(subject.quality).to eql(quality - 2)
        expect(subject.sell_in).to eql(sell_in - 1)
      end
    end

    context 'with sulfuras' do
      let(:name) { GildedRose::SULFURAS }

      it 'sets quality to 80 and never decreases sell_in date' do
        expect(subject.quality).to eql(80)
        expect(subject.sell_in).to eql(sell_in)
      end

    end

    context 'with aged brie' do
      let(:name) { GildedRose::AGED_BRIE }

      it 'increases quality by one and decreases sell_in date by one' do
        expect(subject.quality).to eql(quality + 1)
        expect(subject.sell_in).to eql(sell_in - 1)
      end
    end

    context 'with backstage passes' do
      let(:name) { GildedRose::BACKSTAGE_PASSES }

      context 'with sell by date > 10' do
        let(:sell_in) { 11 }

        it 'increases quality by one and decreases sell_in date by one' do
          expect(subject.quality).to eql(quality + 1)
          expect(subject.sell_in).to eql(sell_in - 1)
        end
      end

      context 'with sell by date of 10' do
        let(:sell_in) { 10 }

        it 'increases quality by two and decreases sell_in date by one' do
          expect(subject.quality).to eql(quality + 2)
          expect(subject.sell_in).to eql(sell_in - 1)
        end
      end

      context 'with sell by date of 5' do
        let(:sell_in) { 5 }

        it 'increases quality by three and decreases sell_in date by one' do
          expect(subject.quality).to eql(quality + 3)
          expect(subject.sell_in).to eql(sell_in - 1)
        end
      end

      context 'with sell by date of 0' do
        let(:sell_in) { 0 }

        it 'decreases sell_in date by one and into a negative' do
          expect(subject.quality).to eql(0)
          expect(subject.sell_in).to eql(-1)
        end
      end
    end

    context 'with normal item' do
      it 'decreases quality and sell_in by one' do
        expect(subject.sell_in).to eql(sell_in - 1)
        expect(subject.quality).to eql(quality - 1)
      end

      context 'with zeroed sell_in value' do
        let(:sell_in) { 0 }

        it 'prevents quality and sell_in values to have negative values' do
          expect(subject.sell_in).to eql(sell_in - 1)
        end

        it 'doubles quality amount decreased' do
          expect(subject.quality).to eql(quality - 2)
        end
      end

      context 'with zeroed quality value' do
        let(:quality) { 0 }

        it 'prevents quality and sell_in values to have negative values' do
          expect(subject.quality).to eql(0)
        end
      end

      context 'with excessive quality value' do
        let(:quality) { 100 }

        xit 'sets quality to max value' do
          expect(subject.quality).to eql(50)
        end
      end
    end

    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    describe 'integration specs' do
      shared_examples :gilded_rose_item_after_two_days do |name:, sell_in:, quality:, expected_sell_in:, expected_quality:|
        let(:item) { Item.new(name, sell_in, quality) }
        let(:instance) { GildedRose.new([item]) }

        subject { instance.update_quality; instance.update_quality[0] }

        it "#{name} with sell_in: #{sell_in} and quantity: #{quality} returns corrected quality" do
          expect(subject.quality).to eql(expected_quality), "expected item quality '#{expected_quality}', got: '#{subject.quality}'"
          expect(subject.sell_in).to eql(expected_sell_in), "expected item sell_in '#{expected_sell_in}', got: '#{subject.sell_in}'"
        end
      end

      context 'with conjured items' do
        it_behaves_like :gilded_rose_item_after_two_days, name: "+5 Dexterity Vest", sell_in: 10, quality: 20, expected_sell_in: 8, expected_quality: 18
        it_behaves_like :gilded_rose_item_after_two_days, name: "Aged Brie", sell_in: 2, quality: 0, expected_sell_in: 0, expected_quality: 2
        it_behaves_like :gilded_rose_item_after_two_days, name: "Elixir of the Mongoose", sell_in: 5, quality: 7, expected_sell_in: 3, expected_quality: 5
        it_behaves_like :gilded_rose_item_after_two_days, name: "Sulfuras, Hand of Ragnaros", sell_in: 0, quality: 80, expected_sell_in: 0, expected_quality: 80
        it_behaves_like :gilded_rose_item_after_two_days, name: "Sulfuras, Hand of Ragnaros", sell_in: -1, quality: 80, expected_sell_in: -1, expected_quality: 80
        it_behaves_like :gilded_rose_item_after_two_days, name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 15, quality: 20, expected_sell_in: 13, expected_quality: 22
        it_behaves_like :gilded_rose_item_after_two_days, name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 10, quality: 49, expected_sell_in: 8, expected_quality: 50
        it_behaves_like :gilded_rose_item_after_two_days, name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 5, quality: 49, expected_sell_in: 3, expected_quality: 50
        it_behaves_like :gilded_rose_item_after_two_days, name: "Conjured Mana Cake", sell_in: 3, quality: 6, expected_sell_in: 1, expected_quality: 2
      end
    end
  end
end
