# This code is free software; you can redistribute it and/or modify it under the
# terms of the new BSD License.
#
# Copyright (c) 2010, Sebastian Staudt

require 'steam/community/tf2/tf2_item'
require 'steam/community/web_api'

# Represents the inventory (aka. Backpack) of a Team Fortress 2 player
class TF2Inventory

  include WebApi

  attr_reader :items

  # Creates a new inventory object for the given SteamID64
  def initialize(steam_id)
    result = json!('ITFItems_440', 'GetPlayerItems', 1, { :SteamID => @steam_id64 })

    @items = []
    result[:items][:item].each do |item_data|
      unless item_data.nil?
        item = TF2Item.new(item_data)
        @items[item.backpack_position - 1] = item
      end
    end
  end

  # Returns the item at the given position in the backpack
  def [](index)
    @items[index]
  end

  # Returns the number of items in the user's backpack
  def size
    @items.size
  end

end