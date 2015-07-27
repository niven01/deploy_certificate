deploy_certificate Cookbook
===========================

This is a library cook that provides a resource to deploy certificates, chains or ca's.  


## In scope  

This cookbook focuses on providing a resource to deploy certificates from whatever source you choose. 

## Out of scope

This cookbook does not create certificate requests or self signed certificates. Its does not rely on a specific data and leaves the location of where you store ther certs up to you.
 


Supports
------------
* Centos 6.6
* More to come.....


Usage
-----
Add cookbook as a dependency in metadata.rb  

`depends 'deploy_certificate'`


## Resources

### `deploy_certificate`  

#### Actions


* `:install` - Installs required cert files to os (Default)
* `:remove` - Deletes cert files from os

#### Parameters  

* `'name'` Certificate name, default: nil
* `'is_sensitive'` Do not display certificate info during converge, default: true
* `'cert'` Certificate source (This should ideally be from a data bag), default: nil
* `'cert_path'` Path of certificate, default: '/etc/pki/tls/certs/'
* `'cert_owner'` Certicate owner, default: 'root'
* `'cert_mode'` Certificate permissions, default: '0644'
* `'key_path'` Path of cert key, default: '/etc/pki/tls/certs/'
* `'key_owner'` Key owner, default: 'root'
* `'key_mode'` Key permissions, default: '0600'
* `'combined'` Combines server cert, CA cert and private key into a single file, default: false
* `'ca'` CA source, default: 'nil'


#### Example  

The source is up to you. It can be attribute or direct from data bag, it is up to you how you get the source.

##### Install cert only  

```ruby
deploy_certificate 'cert_name' do
  cert 'cert_source'
  key 'key_source'
end
```  

##### Install cert and ca  

```ruby
deploy_certificate 'cert_name' do
  cert 'cert_source'
  key 'key_source'
  ca_name 'ca_name'
  ca 'ca_source'
end
```

##### Install cert with combined  

```ruby
deploy_certificate 'cert_name' do
  cert 'cert_source'
  key 'key_source'
  combined true
  ca 'ca_source'
end
```


Contributing
------------

1. Fork the repository on Github  
2. Create a named feature branch (like `add_feature_x`)  
3. Write your change  
4. Write tests for your change (if applicable)  
5. Run the tests, ensuring they all pass  
6. Submit a Pull Request using Github  

License and Authors
-------------------
Authors: Nielsen Pierce (nielsen.pierce@rackspace.co.uk)
