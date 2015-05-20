# encoding: UTF-8
require 'chef/resource/lwrp_base'

class Chef
  class Resource
    class DeployCertificate < Chef::Resource::LWRPBase
      self.resource_name = :deploy_certificate
      actions :install
      default_action :install

      attribute :name, kind_of: String, name_attribute: true
      attribute :key, kind_of: String, default: nil
      attribute :cert, kind_of: String, default: nil
      attribute :cert_path, kind_of: String, default: '/etc/pki/tls/certs/'
      attribute :key_path, kind_of: String, default: '/etc/pki/tls/private/'
    end
  end
end
