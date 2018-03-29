require 'uu_os'

module Plus4uManagerMain
  module Helpers
    # Module for application helper methods
    module AppHelper
      include Plus4uManagerMain::Config::AppConfig

      def get_login(code1, code2)
        UU::OS::Security::Session.login(
            user_credentials: [code1, code2],
            context_scope: UU::OS::Security::Session::CONTEXT_SCOPE_THREAD
        )
      end
    end
  end
end
