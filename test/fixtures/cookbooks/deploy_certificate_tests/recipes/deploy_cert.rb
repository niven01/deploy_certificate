# Encoding: utf-8
#
# Cookbook Name:: deploy_certificate_tests
# Recipe:: deploy_cert
#
# Copyright 2012-2015, Rackspace

# Example show using encrypted data bag

cert = Chef::EncryptedDataBagItem.load('certs', 'cert_test')

deploy_certificate 'cert_test' do
  cert cert['cert']
  key cert['key']
end

# deploy_certificate 'cert_test' do
#   action :remove
# end
