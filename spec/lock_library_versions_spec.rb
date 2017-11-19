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

      context 'files which managed library versions are not included' do
        let(:modified_files) { ['README.md'] }

        it 'no errors' do
          plugin.check
          expect(dangerfile.status_report[:errors].length).to be == 0
        end
      end

      context 'file which managed library versions are included' do
        let(:modified_files) { ['README.md', 'Gemfile'] }

        it 'error' do
          plugin.check
          expect(dangerfile.status_report[:errors].length).to be == 1
          expect(dangerfile.status_report[:errors][0]).to eq 'Gemfile.lock should be committed'
        end
      end

      context 'files which managed library versions are included' do
        let(:modified_files) { ['Cartfile', 'Gemfile'] }

        it 'multiple errors' do
          plugin.check
          expect(dangerfile.status_report[:errors].length).to be == 2
          expect(dangerfile.status_report[:errors][0]).to eq 'Gemfile.lock should be committed'
          expect(dangerfile.status_report[:errors][1]).to eq 'Cartfile.resolved should be committed'
        end
      end

      context 'with lock file' do
        let(:modified_files) { ['Gemfile', 'Gemfile.lock'] }

        it 'no errors' do
          plugin.check
          expect(dangerfile.status_report[:errors].length).to be == 0
        end
      end
    end
  end
end
