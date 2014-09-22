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
        hp:
        {
          current: 16,
          base: 32
        },
        mana:
        {
          current: 64,
          base: 128
        },
        localization:
        {
          logitude: 65.55,
          latitude: 12.33
        },
        inventory:
        {
          gold: 100,
        }
      }
    }

    respond_with obj, status: 200
  end
end
