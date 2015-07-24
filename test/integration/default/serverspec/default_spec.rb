# Encoding: utf-8

require_relative 'spec_helper'

describe file('/etc/pki/tls/certs/cert_test.crt') do
  it { should contain('BEGIN CERTIFICATE') }
end

describe file('/etc/pki/tls/private/cert_test.key') do
  it { should contain('BEGIN KEY') }
end

