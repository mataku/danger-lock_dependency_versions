require 'yaml'

module Danger
  class DangerLockDependencyVersions < Plugin
    def check(config = nil)
      config = config.is_a?(Hash) ? config : { }
      warning_mode = config[:warning] || false
      files = git.modified_files
      lock_list.keys.each do |file|
        if files.include?(file) && !(files.include?(lock_list[file]))
          comment(warning_mode, file)
        end
      end
    end

    private

    def comment(warning_mode, file)
      if warning_mode
        warn(error_message(file))
      else
        fail(error_message(file))
      end
    end

    def error_message(file)
      "`#{file}` has changed. `#{lock_list[file]}` should be committed."
    end

    def lock_list
      YAML.load_file('.lock_list.yml')
    end
  end
end
