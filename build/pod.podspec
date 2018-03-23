Pod::Spec.new do |spec|
  spec.name         = 'Gxlg'
  spec.version      = '{{.Version}}'
  spec.license      = { :type => 'GNU Lesser General Public License, Version 3.0' }
  spec.homepage     = 'https://github.com/logarithm-network/go-logarithm'
  spec.authors      = { {{range .Contributors}}
		'{{.Name}}' => '{{.Email}}',{{end}}
	}
  spec.summary      = 'iOS Logarithm Client'
  spec.source       = { :git => 'https://github.com/logarithm-network/go-logarithm.git', :commit => '{{.Commit}}' }

	spec.platform = :ios
  spec.ios.deployment_target  = '9.0'
	spec.ios.vendored_frameworks = 'Frameworks/Gxlg.framework'

	spec.prepare_command = <<-CMD
    curl https://gxlgstore.blob.core.windows.net/builds/{{.Archive}}.tar.gz | tar -xvz
    mkdir Frameworks
    mv {{.Archive}}/Gxlg.framework Frameworks
    rm -rf {{.Archive}}
  CMD
end
