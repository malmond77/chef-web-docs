module github.com/chef/chef-web-docs

go 1.14

require (
	github.com/chef/automate/components/docs-chef-io v0.0.0-20201026091205-7c9a3bbd6785 // indirect
	github.com/chef/chef-workstation/docs-chef-io v0.0.0-20201021170748-d1878a5c76b2 // indirect
	github.com/chef/desktop-config/docs-chef-io v0.0.0-20200929171526-d4cef8a736df // indirect
	github.com/chef/effortless/docs-chef-io v0.0.0-20200930175149-51c187882fba // indirect
	github.com/inspec/inspec/docs-chef-io v0.0.0-20201022004754-2d19011d6648 // indirect
)

//replace github.com/chef/effortless/docs-chef-io => ../effortless/docs-chef-io
//replace github.com/chef/chef-workstation/docs-chef-io => ../chef-workstation/docs-chef-io
//replace github.com/chef/desktop-config/docs-chef-io => ../desktop-config/docs-chef-io
//replace github.com/inspec/inspec/docs-chef-io => ../inspec/docs-chef-io
//replace github.com/chef/automate/components/docs-chef-io => ../automate/components/docs-chef-io
