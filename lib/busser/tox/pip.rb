# -*- encoding: utf-8 -*-

module Busser
  module Tox
    # Common methods for pip
    #
    # @author Jaime Gil de Sagredo <jaimegildesagredo@gmail.com>
    #
    module Pip
      module_function

      def ensure_pip
        if !pip_installed?
          info '`pip` is not installed, installing ...'
          f = Tempfile.new('busser-tox-pip', Dir.tmpdir, 'wb+')
          f.write(pip_install_script)
          f.flush
          run!("python #{f.path}")
          f.close!
          info '`pip` was successfully installed.'
        end
      end

      def pip_install_script
        uri = URI('https://bootstrap.pypa.io/get-pip.py')
        conn = Net::HTTP.new(uri.host, uri.port)
        conn.use_ssl = true
        conn.start
        conn.get(uri.request_uri).body
      end

      def pip_installed?
        system('pip --version')
        $?.exitstatus == 0
      end

      def pip_install(requirements)
        cmd = "pip install #{requirements}"
        info "Running #{cmd} ..."
        run!(cmd)
      end
    end
  end
end
