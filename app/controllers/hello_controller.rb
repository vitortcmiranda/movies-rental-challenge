class HelloController < ApplicationController
  def index
    render json: { ok: true }
  end
end
