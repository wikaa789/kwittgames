class PagesController < ApplicationController
  def home
      @games = Game.all.reverse_order
  end
end
