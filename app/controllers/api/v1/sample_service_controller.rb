class Api::V1::SampleServiceController < ApplicationController
  def sample
    render status: 200,
      json: {
        success: true,
        info: 'Logged in',
        data: {
          sample: 'sample'
        }
      }
  end
end
