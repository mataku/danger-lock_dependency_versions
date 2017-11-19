require File.expand_path("../spec_helper", __FILE__)

module Danger
  describe Danger::DangerLockLibraryVersions do
    let(:git_plugin) { Danger::DangerfileGitPlugin }
    let(:dangerfile) { testing_dangerfile }
    let(:plugin) { dangerfile.lock_library_versions }

    it "should be a plugin" do
      expect(Danger::DangerLockLibraryVersions < Danger::Plugin).to be_truthy
    end

    describe "#check" do
      before do
        allow_any_instance_of(git_plugin).to receive(:modified_files).and_return(modified_files)
      end

      context 'not included' do
        let(:modified_files) { ['README.md'] }
        it do
          plugin.check
          expect(dangerfile.status_report[:errors][0]).to be_nil
        end
      end

      context 'included' do
        let(:modified_files) { ['README.md', 'Gemfile'] }
        it do
          plugin.check
          expect(dangerfile.status_report[:errors].length).to be == 1
          expect(dangerfile.status_report[:errors][0]).to eq 'Gemfile.lock should be committed'
        end
      end
    end
  end
end
