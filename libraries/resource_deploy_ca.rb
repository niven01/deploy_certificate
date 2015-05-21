# encoding: UTF-8
require 'chef/resource/lwrp_base'

class Chef
  class Resource
    class DeployCa < Chef::Resource::LWRPBase
      self.resource_name = :deploy_ca
      actions :install, :remove
      default_action :install

      attribute :name, kind_of: String, name_attribute: true
      attribute :ca, kind_of: String, default: nil
      attribute :ca_path, kind_of: String, default: '/etc/pki/tls/certs/'
      attribute :ca_owner, kind_of: String, default: 'root'
      attribute :ca_mode, kind_of: String, default: '0644'
    end
  end
end
