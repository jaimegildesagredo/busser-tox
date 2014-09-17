# -*- encoding: utf-8 -*-

require 'busser/runner_plugin'
require 'busser/tox/pip'

module Busser
  module Thor
    class BaseGroup
      include Busser::Tox::Pip
    end
  end

  module RunnerPlugin
    # A Busser runner plugin for Tox.
    #
    # @author Jaime Gil de Sagredo Luna <jaimegildesagredo@gmail.com>
    #
    class Tox < Base
      postinstall do
        ensure_pip
        pip_install('tox')
      end

      def test
        tox_ini = File.join(suite_path('tox').to_s, 'tox.ini')
        run!("tox -c #{tox_ini}")
      end
    end
  end
end
