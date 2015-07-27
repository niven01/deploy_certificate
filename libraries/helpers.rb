module Helpers
  module Subdir
    def ca_name
      return new_resource.ca_name if new_resource.ca_name
      "ca_#{new_resource.name}"
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
