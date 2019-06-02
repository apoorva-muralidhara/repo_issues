class SessionsController < ApplicationController
  def new
    puts "Somebody invoked #new with params #{params.inspect}!"
  end

  def create
    puts "Somebody invoked #create with params #{params.inspect}!"
  end
end
