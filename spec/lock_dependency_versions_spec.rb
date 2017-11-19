require File.expand_path("../spec_helper", __FILE__)
require 'yaml'

module Danger
  describe Danger::DangerLockDependencyVersions do
    let(:git_plugin) { Danger::DangerfileGitPlugin }
    let(:dangerfile) { testing_dangerfile }
    let(:plugin) { dangerfile.lock_dependency_versions }
    let(:load_data) do
      {
        "Gemfile" => "Gemfile.lock",
        "Cartfile" => "Cartfile.resolved"
      }
    end


    it "should be a plugin" do
      expect(Danger::DangerLockDependencyVersions < Danger::Plugin).to be_truthy
    end

    describe "#check" do
      let(:modified_files) { [] }

      shared_examples 'no errors' do
        it do
          plugin.check
          expect(dangerfile.status_report[:errors].length).to be == 0
        end
      end

      before do
        allow(YAML).to receive(:load_file).with('.lock_list.yml').and_return(load_data)
        allow_any_instance_of(git_plugin).to receive(:modified_files).and_return(modified_files)
      end

      it_behaves_like 'no errors'

      context 'files which managed library versions are not included' do
        let(:modified_files) { ['README.md'] }

        it_behaves_like 'no errors'
      end

      context 'file which managed library versions are included' do
        let(:modified_files) { ['README.md', 'Gemfile'] }

        it 'an error has occurred' do
          plugin.check
          expect(dangerfile.status_report[:errors].length).to be == 1
          expect(dangerfile.status_report[:errors][0]).to eq '`Gemfile` has changed. `Gemfile.lock` should be committed.'
        end
      end

      context 'files which managed library versions are included' do
        let(:modified_files) { ['Cartfile', 'Gemfile'] }

        it 'multiple errors have occurred' do
          plugin.check
          expect(dangerfile.status_report[:errors].length).to be == 2
          expect(dangerfile.status_report[:errors]).to include '`Gemfile` has changed. `Gemfile.lock` should be committed.'
          expect(dangerfile.status_report[:errors]).to include '`Cartfile` has changed. `Cartfile.resolved` should be committed.'
        end
      end

      context 'with lock file' do
        let(:modified_files) { ['Gemfile', 'Gemfile.lock'] }

        it_behaves_like 'no errors'
      end

      context 'only lock file has committed' do
        let(:modified_files) { ['Gemfile.lock'] }

        it_behaves_like 'no errors'
      end

      context 'warning: true' do
        let(:modified_files) { ['Gemfile'] }

        it 'should warning, not error' do
          plugin.check(warning: true)
          expect(dangerfile.status_report[:warnings].length).to be == 1
          expect(dangerfile.status_report[:errors].length).to be == 0
          expect(dangerfile.status_report[:warnings][0]).to eq '`Gemfile` has changed. `Gemfile.lock` should be committed.'
        end
      end
    end
  end
end
