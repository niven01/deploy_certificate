# Encoding: utf-8
#
# Cookbook Name:: deploy_certificate_tests
# Recipe:: deploy_combined
#
# Copyright 2012-2015, Rackspace

deploy_certificate 'cert_test' do
  cert '-----BEGIN CERTIFICATE-----\ncertificate\n-----END CERTIFICATE-----'
  key '-----BEGIN KEY-----\nkey\n-----END KEY-----'
  combined true
  ca '-----BEGIN CERTIFICATE-----\nca_certificate\n-----END CERTIFICATE-----'
end

# deploy_certificate 'cert_test' do
#   combined true
#   action :remove
# end