---
resource_reference: true
resources_common_guards: true
resources_common_notification: true
resources_common_properties: true
title: openssl_rsa_private_key resource
resource: openssl_rsa_private_key
aliases:
- "/resource_openssl_rsa_private_key.html"
menu:
  infra:
    title: openssl_rsa_private_key
    identifier: chef_infra/cookbook_reference/resources/openssl_rsa_private_key openssl_rsa_private_key
    parent: chef_infra/cookbook_reference/resources
resource_description_list:
- markdown: Use the **openssl_rsa_private_key** resource to generate RSA private key
    files. If a valid RSA key file can be opened at the specified location, no new
    file will be created. If the RSA key file cannot be opened, either because it
    does not exist or because the password to the RSA key file does not match the
    password in the recipe, it will be overwritten.
resource_new_in: '14.0'
syntax_full_code_block: |-
  openssl_rsa_private_key 'name' do
    force           true, false # default value: false
    group           String, Integer
    key_cipher      String # default value: "des3"
    key_length      Integer # default value: 2048
    key_pass        String
    mode            Integer, String # default value: "0600"
    owner           String, Integer
    path            String # default value: 'name' unless specified
    action          Symbol # defaults to :create if not specified
  end
syntax_properties_list:
syntax_full_properties_list:
- "`openssl_rsa_private_key` is the resource."
- "`name` is the name given to the resource block."
- "`action` identifies which steps Chef Infra Client will take to bring the node into
  the desired state."
- "`force`, `group`, `key_cipher`, `key_length`, `key_pass`, `mode`, `owner`, and
  `path` are the properties available to this resource."
actions_list:
  :create:
    markdown:
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: force
  ruby_type: true, false
  required: false
  default_value: 'false'
  description_list:
  - markdown: Force creation of the key even if the same key already exists on the
      node.
- property: group
  ruby_type: String, Integer
  required: false
  description_list:
  - markdown: The group ownership applied to all files created by the resource.
- property: key_cipher
  ruby_type: String
  required: false
  default_value: des3
  description_list:
  - markdown: The designed cipher to use when generating your key. Run `openssl list-cipher-algorithms`
      to see available options.
- property: key_length
  ruby_type: Integer
  required: false
  default_value: '2048'
  allowed_values: 1024, 2048, 4096, 8192
  description_list:
  - markdown: The desired bit length of the generated key.
- property: key_pass
  ruby_type: String
  required: false
  description_list:
  - markdown: The desired passphrase for the key.
- property: mode
  ruby_type: Integer, String
  required: false
  default_value: '0600'
  description_list:
  - markdown: The permission mode applied to all files created by the resource.
- property: owner
  ruby_type: String, Integer
  required: false
  description_list:
  - markdown: The owner applied to all files created by the resource.
- property: path
  ruby_type: String
  required: false
  default_value: The resource block's name
  description_list:
  - markdown: An optional property for specifying the path to write the file to if
      it differs from the resource block's name.
examples: |
  Generate new 2048bit key with the default des3 cipher

  ```ruby
  openssl_rsa_private_key '/etc/ssl_files/rsakey_des3.pem' do
    key_length 2048
    action :create
  end
  ```

  Generate new 1024bit key with the aes-128-cbc cipher

  ```ruby
  openssl_rsa_private_key '/etc/ssl_files/rsakey_aes128cbc.pem' do
    key_length 1024
    key_cipher 'aes-128-cbc'
    action :create
  end
  ```
---