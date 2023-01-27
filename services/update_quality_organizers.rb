
# class UpdateQualityOrchestrator < ApplicationOrganizer
#   def self.call(context)
#     with(context).reduce(actions(context))
#   end
#
#   def self.actions(context)
#     [
#       add_to_context(name: context.dig(:input, :name)),
#       execute(->(ctx) do
#         organizer_ctx = get_organizer(context).call(ctx)
#         ctx.merge!(organizer_ctx.slice(:sell_in, :quality))
#       end)
#     ]
#   end
#
#   def self.get_organizer(ctx)
#     name = ctx.dig(:input, :name)
#     return ConjuredUpdateQualityOrganizer if CONJURED_ITEMS.include?(name)
#     return LegendaryUpdateQualityOrganizer if LEGENDARY_ITEMS.include?(name)
#     return WellAgedUpdateQualityOrganizer if name == AGED_BRIE
#     return BackstageUpdateQualityOrganizer if name == BACKSTAGE_PASSES
#
#     NormalUpdateQualityOrganizer
#   end
# end
