require 'chef/provider/lwrp_base'
require_relative 'helpers'

class Chef
  class Provider
    class DeployCertificate < Chef::Provider::LWRPBase
      use_inline_resources if defined?(use_inline_resources)
      include Helpers::Subdir
      def whyrun_supported?
        true
      end

      action :install do
        # check key and cert exist
        fail 'Key is missing, can\'t deploy certificate' unless new_resource.key && new_resource.cert

        %w(cert_path key_path).each do |path|
          directory path do
            owner 'root'
            group 'root'
            mode 0755
            recursive true
            not_if { ::File.exist?(path) }
          end
        end

        file ::File.join(cert_path, new_resource.name + '.crt') do
          owner new_resource.cert_owner
          mode new_resource.cert_mode
          content new_resource.cert
          sensitive new_resource.is_sensitive
          not_if { new_resource.combined }
        end

        if new_resource.ca && ca_name 
          file ::File.join(cert_path, ca_name + '_bundle.crt') do
            owner new_resource.cert_owner
            mode new_resource.cert_mode
            content new_resource.ca
            sensitive new_resource.is_sensitive
            not_if { new_resource.combined }
          end
        end

        if new_resource.combined
          file ::File.join(cert_path, new_resource.name + '_combined.crt') do
            owner new_resource.cert_owner
            mode new_resource.cert_mode
            content "#{new_resource.cert}\n#{new_resource.ca}\n#{new_resource.key}}"
            sensitive new_resource.is_sensitive
          end
        end

        file ::File.join(key_path, new_resource.name + '.key') do
          owner new_resource.key_owner
          mode new_resource.key_mode
          content new_resource.key
          sensitive new_resource.is_sensitive
          not_if { new_resource.combined }
        end
      end

      action :remove do
        if new_resource.name
          file ::File.join(cert_path, new_resource.name + '.crt') do
            action :delete
            only_if { ::File.exist?(::File.join(cert_path, new_resource.name + '.crt')) }
          end

          file ::File.join(key_path, new_resource.name + '.key') do
            action :delete
            only_if { ::File.exist?(::File.join(key_path, new_resource.name + '.key')) }
          end
        end

        if ca_name
          file ::File.join(cert_path, ca_name + '_bundle.crt') do
            action :delete
            only_if { ::File.exist?(::File.join(cert_path, ca_name + '_bundle.crt')) }
          end
        end

        if new_resource.combined
          file ::File.join(cert_path, new_resource.name + '_combined.crt') do
            action :delete
            only_if { ::File.exist?(::File.join(cert_path, new_resource.name + '_combined.crt')) }
          end
        end
      end
    end
  end
end
