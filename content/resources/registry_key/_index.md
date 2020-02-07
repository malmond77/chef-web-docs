---
title: registry_key resource
resource: registry_key
draft: false
aliases: /resource_registry_key.html
menu:
  docs:
    title: registry_key
    identifier: chef_infra/cookbook_reference/resources/resource_registry_key.md registry_key
    parent: chef_infra/cookbook_reference/resources
    weight: 820
resource_reference: true
robots: null
resource_description_list:
- markdown: 'Use the **registry_key** resource to create and delete registry keys
    in

    Microsoft Windows.'
- note:
    markdown: '64-bit versions of Microsoft Windows have a 32-bit compatibility layer

      in the registry that reflects and redirects certain keys (and their

      values) into specific locations (or logical views) of the registry hive.


      Chef Infra Client can access any reflected or redirected registry key.

      The machine architecture of the system on which Chef Infra Client is

      running is used as the default (non-redirected) location. Access to the

      `SysWow64` location is redirected must be specified. Typically, this is

      only necessary to ensure compatibility with 32-bit applications that are

      running on a 64-bit operating system.


      32-bit versions of Chef Infra Client (12.8 and earlier) and 64-bit

      versions of Chef Infra Client (12.9 and later) generally behave the same

      in this situation, with one exception: it is only possible to read and

      write from a redirected registry location using chef-client version 12.9

      (and later).


      For more information, see: [Registry

      Reflection](https://msdn.microsoft.com/en-us/library/windows/desktop/aa384235(v=vs.85).aspx).'
resource_new_in: null
handler_types: false
syntax_description: 'A **registry_key** resource block creates and deletes registry
  keys in Microsoft Windows:'
syntax_code_block: "registry_key 'HKEY_LOCAL_MACHINE\\\\...\\\\System' do\n  values\
  \ [{\n    name: 'NewRegistryKeyValue',\n    type: :multi_string,\n    data: %w(foo\
  \ bar baz),\n  }]\n  action :create\nend"
syntax_properties_list:
- '`registry_key` is the resource'
- '`name` is the name of the resource block'
- '`values` is a hash that contains at least one registry key to be created or deleted.
  Each registry key in the hash is grouped by brackets in which the `name:`, `type:`,
  and `data:` values for that registry key are specified.'
- "`type:` represents the values available for registry keys in Microsoft Windows.\
  \ Use `:binary` for REG_BINARY, `:string` for REG_SZ, `:multi_string` for REG_MULTI_SZ,\
  \ `:expand_string` for REG_EXPAND_SZ, `:dword` for REG_DWORD, `:dword_big_endian`\
  \ for REG_DWORD_BIG_ENDIAN, or `:qword` for REG_QWORD.\n {{< warning >}}\n `:multi_string`\
  \ must be an array, even if there is only a single string.\n {{< /warning >}}"
- '`action` identifies the steps Chef Infra Client will take to bring the node into
  the desired state'
- '`architecture`, `key`, `recursive` and `values` are properties of this resource,
  with the Ruby type shown. See "Properties" section below for more information about
  all of the properties that may be used with this resource.


  Registry Key Path Separators'
- '{{% windows_registry_key_backslashes %}}


  Recipe DSL Methods'
- '{{% dsl_recipe_method_windows_methods %}}


  {{% notes_dsl_recipe_order_for_windows_methods %}}


  ### registry_data_exists?


  {{% dsl_recipe_method_registry_data_exists %}}


  ### registry_get_subkeys


  {{% dsl_recipe_method_registry_get_subkeys %}}


  ### registry_get_values


  {{% dsl_recipe_method_registry_get_values %}}


  ### registry_has_subkeys?


  {{% dsl_recipe_method_registry_has_subkeys %}}


  ### registry_key_exists?


  {{% dsl_recipe_method_registry_key_exists %}}


  ### registry_value_exists?


  {{% dsl_recipe_method_registry_value_exists %}}'
syntax_full_code_block: null
syntax_full_properties_list: null
syntax_shortcode: null
registry_key: true
nameless_apt_update: false
nameless_build_essential: false
resource_package_options: false
actions_list:
  :create:
    markdown: Default. Create a registry key. If a registry key already exists (but
      does not match), update that registry key to match.
  :create_if_missing:
    markdown: Create a registry key if it does not exist. Also, create a registry
      key value if it does not exist.
  :delete:
    markdown: Delete the specified values for a registry key.
  :delete_key:
    markdown: Delete the specified registry key and all of its subkeys. The `:delete_key`
      action with the `recursive` attribute will delete the registry key, all of its
      values and all of the names, types, and data associated with them. This cannot
      be undone by Chef Infra Client.
  :nothing:
    shortcode: resources_common_actions_nothing.md
properties_list:
- property: architecture
  ruby_type: Symbol
  required: false
  default_value: :machine
  new_in: null
  description_list:
  - markdown: 'The architecture of the node for which keys are to be created or

      deleted. Possible values: `:i386` (for nodes with a 32-bit

      registry), `:x86_64` (for nodes with a 64-bit registry), and

      `:machine` (to have Chef Infra Client determine the architecture

      during a Chef Infra Client run).


      In order to read or write 32-bit registry keys on 64-bit machines

      running Microsoft Windows, the `architecture` property must be set

      to `:i386`. The `:x86_64` value can be used to force writing to a

      64-bit registry location, but this value is less useful than the

      default (`:machine`) because Chef Infra Client returns an exception

      if `:x86_64` is used and the machine turns out to be a 32-bit

      machine (whereas with `:machine`, Chef Infra Client is able to

      access the registry key on the 32-bit machine).'
- property: key
  ruby_type: String
  required: false
  default_value: The resource blocks name
  new_in: null
  description_list:
  - markdown: 'The path to the location in which a registry key is to be created or

      from which a registry key is to be deleted. Default value: the

      `name` of the resource block. See "Syntax" section above for more

      information. The path must include the registry hive, which can be

      specified either as its full name or as the 3- or 4-letter

      abbreviation. For example, both `HKLM\SECURITY` and

      `HKEY_LOCAL_MACHINE\SECURITY` are both valid and equivalent. The

      following hives are valid: `HKEY_LOCAL_MACHINE`, `HKLM`,

      `HKEY_CURRENT_CONFIG`, `HKCC`, `HKEY_CLASSES_ROOT`, `HKCR`,

      `HKEY_USERS`, `HKU`, `HKEY_CURRENT_USER`, and `HKCU`.'
- property: recursive
  ruby_type: true, false
  required: false
  default_value: 'false'
  new_in: null
  description_list:
  - markdown: 'When creating a key, this value specifies that the required keys for

      the specified path are to be created. When using the `:delete_key`

      action in a recipe, and if the registry key has subkeys, then set

      the value for this property to `true`. The `:delete_key` action with

      the `recursive` attribute will delete the registry key, all of its

      values and all of the names, types, and data associated with them.

      This cannot be undone by Chef Infra Client.'
- property: values
  ruby_type: Hash, Array
  required: false
  default_value: null
  new_in: null
  description_list:
  - markdown: 'An array of hashes, where each Hash contains the values that are to

      be set under a registry key. Each Hash must contain `name:`,

      `type:`, and `data:` (and must contain no other key values).


      `type:` represents the values available for registry keys in

      Microsoft Windows. Use `:binary` for REG_BINARY, `:string` for

      REG_SZ, `:multi_string` for REG_MULTI_SZ, `:expand_string` for

      REG_EXPAND_SZ, `:dword` for REG_DWORD, `:dword_big_endian` for

      REG_DWORD_BIG_ENDIAN, or `:qword` for REG_QWORD.'
  - warning:
    - markdown: '


        `:multi_string` must be an array, even if there is only a single

        string.


        '
properties_shortcode: null
properties_multiple_packages: false
resource_directory_recursive_directories: false
resources_common_atomic_update: false
properties_resources_common_windows_security: false
remote_file_prevent_re_downloads: false
remote_file_unc_path: false
ps_credential_helper: false
ruby_style_basics_chef_log: false
debug_recipes_chef_shell: false
template_requirements: false
resources_common_properties: false
resources_common_notification: false
resources_common_guards: false
common_resource_functionality_multiple_packages: false
resources_common_guard_interpreter: false
remote_directory_recursive_directories: false
directory_recursive_directories: false
common_resource_functionality_resources_common_windows_security: false
handler_custom: false
cookbook_file_specificity: false
unit_file_verification: false
examples_list:
- example_heading: Create a registry key
  text_blocks:
  - markdown: 'Use a double-quoted string:'
  - code_block: "registry_key \"HKEY_LOCAL_MACHINE\\\\path-to-key\\\\Policies\\\\\
      System\" do\n  values [{\n    name: 'EnableLUA',\n    type: :dword,\n    data:\
      \ 0\n  }]\n  action :create\nend"
  - markdown: 'or a single-quoted string:'
  - code_block: "registry_key 'HKEY_LOCAL_MACHINE\\path-to-key\\Policies\\System'\
      \ do\n  values [{\n    name: 'EnableLUA',\n    type: :dword,\n    data: 0\n\
      \  }]\n  action :create\nend"
- example_heading: Delete a registry key value
  text_blocks:
  - markdown: 'Use a double-quoted string:'
  - code_block: "registry_key \"HKEY_LOCAL_MACHINE\\\\SOFTWARE\\\\path\\\\to\\\\key\\\
      \\AU\" do\n  values [{\n    name: 'NoAutoRebootWithLoggedOnUsers',\n    type:\
      \ :dword,\n    data: ''\n    }]\n  action :delete\nend"
  - markdown: 'or a single-quoted string:'
  - code_block: "registry_key 'HKEY_LOCAL_MACHINE\\SOFTWARE\\path\\to\\key\\AU' do\n\
      \  values [{\n    name: 'NoAutoRebootWithLoggedOnUsers',\n    type: :dword,\n\
      \    data: ''\n    }]\n  action :delete\nend"
  - note: 'If `data:` is not specified, you get an error:

      `Missing data key in RegistryKey values hash`'
- example_heading: Delete a registry key and its subkeys, recursively
  text_blocks:
  - markdown: 'Use a double-quoted string:'
  - code_block: "registry_key \"HKCU\\\\SOFTWARE\\\\Policies\\\\path\\\\to\\\\key\\\
      \\Themes\" do\n  recursive true\n  action :delete_key\nend"
  - markdown: 'or a single-quoted string:'
  - code_block: "registry_key 'HKCU\\SOFTWARE\\Policies\\path\\to\\key\\Themes' do\n\
      \  recursive true\n  action :delete_key\nend"
  - note: 'Be careful when using the `:delete_key` action with the `recursive`

      attribute. This will delete the registry key, all of its values and all

      of the names, types, and data associated with them. This cannot be

      undone by Chef Infra Client.'
- example_heading: Use re-directed keys
  text_blocks:
  - markdown: 'In 64-bit versions of Microsoft Windows,

      `HKEY_LOCAL_MACHINE\SOFTWARE\Example` is a re-directed key. In the

      following examples, because `HKEY_LOCAL_MACHINE\SOFTWARE\Example` is a

      32-bit key, the output will be "Found 32-bit key" if they are run on a

      version of Microsoft Windows that is 64-bit:'
  - code_block: "registry_key \"HKEY_LOCAL_MACHINE\\\\SOFTWARE\\\\Example\" do\n \
      \ architecture :i386\n  recursive true\n  action :create\nend"
  - markdown: 'or:'
  - code_block: "registry_key \"HKEY_LOCAL_MACHINE\\\\SOFTWARE\\\\Example\" do\n \
      \ architecture :x86_64\n  recursive true\n  action :delete_key\nend"
  - markdown: 'or:'
  - code_block: "ruby_block 'check 32-bit' do\n  block do\n    puts 'Found 32-bit\
      \ key'\n  end\n  only_if {\n    registry_key_exists?(\"HKEY_LOCAL_MACHINE\\\
      SOFTWARE\\\\Example\",\n    :i386)\n  }\nend"
  - markdown: 'or:'
  - code_block: "ruby_block 'check 64-bit' do\n  block do\n    puts 'Found 64-bit\
      \ key'\n  end\n  only_if {\n    registry_key_exists?(\"HKEY_LOCAL_MACHINE\\\\\
      SOFTWARE\\\\Example\",\n    :x86_64)\n  }\nend"
- example_heading: Set proxy settings to be the same as those used by Chef Infra Client
  text_blocks:
  - markdown: 'Use a double-quoted string:'
  - code_block: "proxy = URI.parse(Chef::Config[:http_proxy])\nregistry_key 'HKCU\\\
      Software\\Microsoft\\path\\to\\key\\Internet Settings' do\n  values [{name:\
      \ 'ProxyEnable', type: :reg_dword, data: 1},\n          {name: 'ProxyServer',\
      \ data: \"#{proxy.host}:#{proxy.port}\"},\n          {name: 'ProxyOverride',\
      \ type: :reg_string, data: <local>},\n         ]\n  action :create\nend"
  - markdown: 'or a single-quoted string:'
  - code_block: "proxy = URI.parse(Chef::Config[:http_proxy])\nregistry_key 'HKCU\\\
      Software\\Microsoft\\path\\to\\key\\Internet Settings' do\n  values [{name:\
      \ 'ProxyEnable', type: :reg_dword, data: 1},\n          {name: 'ProxyServer',\
      \ data: \"#{proxy.host}:#{proxy.port}\"},\n          {name: 'ProxyOverride',\
      \ type: :reg_string, data: <local>},\n         ]\n  action :create\nend"
  - markdown: '**Set the name of a registry key to "(Default)"**


      Use a double-quoted string:'
  - code_block: "registry_key 'Set (Default) value' do\n  key \"HKLM\\\\Software\\\
      \\Test\\\\Key\\\\Path\"\n  values [\n    {name: '', type: :string, data: 'test'},\n\
      \  ]\n  action :create\nend"
  - markdown: 'or a single-quoted string:'
  - code_block: "registry_key 'Set (Default) value' do\n  key 'HKLM\\Software\\Test\\\
      Key\\Path'\n  values [\n    {name: '', type: :string, data: 'test'},\n  ]\n\
      \  action :create\nend"
  - markdown: 'where `name: ''''` contains an empty string, which will set the name
      of

      the registry key to `(Default)`.'

---