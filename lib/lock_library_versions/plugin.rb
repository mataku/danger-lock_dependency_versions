module Danger
  class DangerLockLibraryVersions < Plugin
    def check
      files = git.modified_files
      lock_list.keys.each do |file|
        if files.include?(file.to_s) && !(files.include?(lock_list[file]))
          fail("#{lock_list[file]} should be committed")
        end
      end
    end

    private

    def lock_list
      {
        'Gemfile': 'Gemfile.lock',
        'Cartfile': 'Cartfile.resolved',
        'Podfile': 'Podfile.lock'
      }
    end
  end
end
