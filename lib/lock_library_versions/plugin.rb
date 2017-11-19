module Danger
  class DangerLockLibraryVersions < Plugin
    def check(config = nil)
      config = config.is_a?(Hash) ? config : { }
      warning_mode = config[:warning] || false
      files = git.modified_files
      lock_list.keys.each do |file|
        if files.include?(file.to_s) && !(files.include?(lock_list[file]))
          message(warning_mode, file)
        end
      end
    end

    private

    def message(warning_mode, file)
      if warning_mode
        warn("#{lock_list[file]} should be committed")
      else
        fail("#{lock_list[file]} should be committed")
      end
    end

    def lock_list
      {
        'Gemfile': 'Gemfile.lock',
        'Cartfile': 'Cartfile.resolved',
        'Podfile': 'Podfile.lock'
      }
    end
  end
end
