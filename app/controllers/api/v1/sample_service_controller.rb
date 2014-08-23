class Api::V1::SampleServiceController < ApplicationController
  respond_to :json

  def sample
    obj = { success: true, info: 'Logged in', data: { sample: 'sample'  }  }
    respond_with obj, status: 200
  end
end
