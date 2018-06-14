require 'rails_helper'
require_relative "../app/jobs/regular/send_download_drive_link.rb"

describe DownloadersController, type: :controller do
  before {
    SiteSetting.discourse_sync_to_googledrive_enabled = true
  }

  context "while logged in as an admin" do

    before { @admin = log_in(:admin) }

    it "is a subclass of Admin::AdminController" do
      expect(DownloadersController < Admin::AdminController).to eq(true)
    end

    describe "GET #index" do
      let(:sample_json) {
        "{\"files\":[
            {
            \"title\":\"discourse-2017-08-24-085545-v20170803123704.sql.gz\",
            \"file_id\":\"0B7WjYjWZJv_4MENlYUM2SjkyU1E\",
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
        get :index, format: :json, xhr: true
        expect(response.body).to eq(sample_json)
      end

      it "responds with 200 status" do
        get :index, xhr: true
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    end

    describe "PUT #create" do
      let(:sample_file_id) { "0B7WjYjWZJv_4blA0a2p6RzVraFE" }
      let(:download_path) { "http://example.com/path/to/download" }
      let(:job_klass) { Jobs::SendDownloadDriveLink }

      before {
        SiteSetting.queue_jobs = true
        drive_instance = DiscourseDownloadFromDrive::DriveDownloader
        drive_instance.any_instance.stubs(:file_id).returns(sample_file_id)
        drive_instance.any_instance.stubs(:download).returns(download_path)
      }

      it "sends a google-file-id to the job" do
        expect do
          put :create,
              xhr: true,
              params: { file_id: sample_file_id },
              format: :json
          expect(response).to be_success
          expect(response).to have_http_status(200)
        end.to change { job_klass.jobs.count }.by(1)

        job_args = job_klass.jobs.last['args'].first
        expect(job_args['to_address']).to eq(@admin.email)
        expect(job_args['drive_url']).to include("/admin/plugins/discourse-sync-to-googledrive/downloader/")
      end
    end
  end
end
