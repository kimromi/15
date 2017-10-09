class AppController < ApplicationController
  def index
    render template: 'app/welcome' unless signed_in?
  end
end
