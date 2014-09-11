class Api::V1::SampleServiceController < ApplicationController
  respond_to :json

  skip_before_action :authenticate_with_token!

  def sample
    obj = { success: true, info: 'Logged in', data: { sample: 'sample'  }  }
    respond_with obj, status: 200
  end

  def sample_user
    obj =
    {
      user:
      {
        name: 'Sampler',
        gold: 1,
        hp:
        {
          current: 16,
          base: 32
        },
        mana:
        {
          current: 64,
          base: 128
        }
      }
    }

    respond_with obj, status: 200
  end
end
