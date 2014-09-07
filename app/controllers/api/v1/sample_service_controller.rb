class Api::V1::SampleServiceController < ApplicationController
  respond_to :json

  skip_before_action :authenticate_with_token!, only: [:sample]

  def sample
    obj = { success: true, info: 'Logged in', data: { sample: 'sample'  }  }
    respond_with obj, status: 200
  end
end
