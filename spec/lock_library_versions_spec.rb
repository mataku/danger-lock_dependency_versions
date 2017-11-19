require File.expand_path("../spec_helper", __FILE__)

module Danger
  describe Danger::DangerLockLibraryVersions do
    it "should be a plugin" do
      expect(Danger::DangerLockLibraryVersions < Danger::Plugin).to be_truthy
    end

    describe "with Dangerfile" do
      before do
        @dangerfile = testing_dangerfile
        @my_plugin = @dangerfile.lock_library_versions
      end
    end
  end
end
