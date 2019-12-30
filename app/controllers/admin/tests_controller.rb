class Admin::TestsController < ApplicationController
  
  #before_action :require_user

  def index
    @tests = Test.all
  end
end