# Encoding: utf-8
#
# Cookbook Name:: deploy_certificate_tests
# Recipe:: deploy_cert
#
# Copyright 2012-2015, Rackspace

deploy_certificate 'cert_test' do
  cert '-----BEGIN CERTIFICATE-----\nccertificate\n-----END CERTIFICATE-----'
  key '-----BEGIN KEY-----\nkey\n-----END KEY-----'
end
