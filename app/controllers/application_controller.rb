# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionsHelper

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def hello
    render html: 'hola, mundo!'
  end

  def goodbye
    render html: 'goodbye, world!'
  end

  private

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
