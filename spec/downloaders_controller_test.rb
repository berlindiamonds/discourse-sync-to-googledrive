require 'rails_helper'

describe ApplicationController::DownloadersController, type: :controller do

  describe "GET show" do
    it "lists all the files" do
      get show_path
      assert_response :success
    end
  end
end
