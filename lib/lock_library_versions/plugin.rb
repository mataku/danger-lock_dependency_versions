require 'yaml'

module Danger
  # This is your plugin class. Any attributes or methods you expose here will
  # be available from within your Dangerfile.
  #
  # To be published on the Danger plugins site, you will need to have
  # the public interface documented. Danger uses [YARD](http://yardoc.org/)
  # for generating documentation from your plugin source, and you can verify
  # by running `danger plugins lint` or `bundle exec rake spec`.
  #
  # You should replace these comments with a public description of your library.
  
  class DangerLockLibraryVersions < Plugin

    def check
      modified_files = git.modified_files
      lock_list.keys.each do |file|
        modified_files.include?(file)
          fail("#{lock_list[file]} should be committed")
        end
      end
    end

    def lock_list
      @list ||= YAML.load_file('./list.yml')
    end
  end
end
