module Plus4uSearchUserMain
  module Errors
    class BaseError < UuApp::AppServer::Error::UseCaseError
      CODE_PREFIX = "#{Plus4uSearchUserMain::PRODUCT}"

      def initialize(dto_out, param_map = {})
        super(self.class::MESSAGE)
        self.code = "#{self.class::ERROR_CODE}"
        self.status = 400
        self.param_map.merge!(param_map)
        self.dto_out = dto_out
      end
    end
  end
end
