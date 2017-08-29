require 'rails_helper'

describe ApplicationController::DownloadersController, type: :controller do

  it "is a subclass of ApplicationController" do
    expect(DownloadersController < ApplicationController).to eq(true)
  end

  describe "GET #show" do
    let(:sample_json) {
      "{\"files\":[
          {
          \"title\":\"discourse-2017-08-24-085545-v20170803123704.sql.gz\",
          \"id\":\"0B7WjYjWZJv_4MENlYUM2SjkyU1E\",
          \"size\":\"14070939\",
          \"created_at\":\"2017-08-24T06:56:21.698+00:00\"
          }
        ]
      }"
    }

    before {
      drive_instance = DiscourseDownloadFromDrive::DriveDownloader
      drive_instance.any_instance.stubs(:json_list).returns(sample_json)
    }

    it "returns a json list of all google_drive files" do
      xhr :get, :show, format: :json
      expect(response.body).to eq(sample_json)
    end

    it "responds with 200 status" do
      xhr :get, :show
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

  end
end
