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
    def cert_path
      case node['platform_family']
      when 'rhel'
        return '/etc/pki/tls/certs'
      when 'debian'
        return '/etc/ssl/certs'
      end
    end
    def key_path
      case node['platform_family']
      when 'rhel'
        return '/etc/pki/tls/private'
      when 'debian'
        return '/etc/ssl/private'
      end
    end
  end
end
