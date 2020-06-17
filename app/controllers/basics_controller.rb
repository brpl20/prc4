class BasicsController < ApplicationController

  def create
    @basic = Basic.new(basic_params)
  end

  def check
    Basic.last
  end

end
