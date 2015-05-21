# encoding: UTF-8
require 'chef/resource/lwrp_base'

class Chef
  class Resource
    class DeployCertificate < Chef::Resource::LWRPBase
      self.resource_name = :deploy_certificate
      actions :install, :remove
      default_action :install

      attribute :name, kind_of: String, name_attribute: true
      attribute :is_sensitive, kind_of: [TrueClass, FalseClass], default: true

      attribute :cert, kind_of: String, default: nil
      attribute :cert_path, kind_of: String, default: '/etc/pki/tls/certs/'
      attribute :cert_owner, kind_of: String, default: 'root'
      attribute :cert_mode, kind_of: String, default: '0644'

      attribute :key, kind_of: String, default: nil
      attribute :key_path, kind_of: String, default: '/etc/pki/tls/private/'
      attribute :key_owner, kind_of: String, default: 'root'
      attribute :key_mode, kind_of: String, default: '0600'

      attribute :chain, kind_of: [TrueClass, FalseClass], default: false
      attribute :ca_name, kind_of: String, default: nil
      attribute :ca, kind_of: String, default: nil
    end
  end
end
