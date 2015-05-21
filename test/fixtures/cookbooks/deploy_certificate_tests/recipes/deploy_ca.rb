# Encoding: utf-8
#
# Cookbook Name:: deploy_certificate_tests
# Recipe:: deploy_ca
#
# Copyright 2012-2015, Rackspace

deploy_certificate 'cert_test' do
  cert '-----BEGIN CERTIFICATE-----\ncertificate\n-----END CERTIFICATE-----'
  key '-----BEGIN KEY-----\nkey\n-----END KEY-----'
  ca_name 'ca_test'
  ca '-----BEGIN CERTIFICATE-----\nca_certificate\n-----END CERTIFICATE-----'
end
