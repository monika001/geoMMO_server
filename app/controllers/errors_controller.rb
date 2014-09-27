class ErrorsController < ActionController::Base
  def not_found
    head :not_found
  end

  def exception
    head :internal_server_error
  end
end
