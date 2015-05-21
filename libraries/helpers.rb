module Helpers
  module Subdir
    def create_subdir(path)
      directory path do
        owner 'root'
        group 'root'
        mode 0755
        recursive true
      end
    end
  end
end
