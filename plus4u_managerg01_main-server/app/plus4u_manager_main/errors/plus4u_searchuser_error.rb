module Plus4uSearchUserMain
  module Errors
    module Plus4uSearchUserError

    end
  end
end

module Plus4uSearchUserMain::Errors::Plus4uSearchUserError

  module InitErrors
    UC_CODE = "#{Plus4uSearchUserMain::APP_CODE}/init"

    class InvalidDtoIn < Plus4uSearchUserMain::Errors::BaseError
      ERROR_CODE = "#{UC_CODE}/invalidDtoIn"
      MESSAGE = 'Invalid DtoIn'
    end
    class SysSetProfileFailed < Plus4uSearchUserMain::Errors::BaseError
      ERROR_CODE = "#{UC_CODE}/sys/setProfileFailed"
      MESSAGE = 'Create uuAppProfile failed.'
    end
    class Plus4uSearchUserExists  < Plus4uSearchUserMain::Errors::BaseError
      ERROR_CODE = "#{UC_CODE}/plus4uSearchUserExists"
      MESSAGE = 'uuObject plus4uSearchUser in active/initializing state already exists.'
    end
    class Plus4uSearchUserDaoCreateFailed  < Plus4uSearchUserMain::Errors::BaseError
      ERROR_CODE = "#{UC_CODE}/plus4uSearchUserDaoCreateFailed"
      MESSAGE = 'Create plus4uSearchUser by Dao create failed.'
    end
    class Plus4uSearchUserDaoUpdateFailed  < Plus4uSearchUserMain::Errors::BaseError
      ERROR_CODE = "#{UC_CODE}/plus4uSearchUserDaoUpdateFailed"
      MESSAGE = 'Setting state on plus4uSearchUser failed.'
    end
    class Plus4uSearchUserDaoCreateSchemaFailed  < Plus4uSearchUserMain::Errors::BaseError
      ERROR_CODE = "#{UC_CODE}/plus4uSearchUserDaoCreateSchemaFailed"
      MESSAGE = 'Create uuObject schema by uuObject DAO createSchema failed.'
    end
  end

  module LoadEnvironmentErrors
    UC_CODE = "#{Plus4uSearchUserMain::APP_CODE}/loadEnvironment"

    class InvalidDtoIn < Plus4uSearchUserMain::Errors::BaseError
      ERROR_CODE = "#{UC_CODE}/invalidDtoIn"
      MESSAGE = 'Invalid DtoIn.'
    end
    class Plus4uSearchUserDoesNotExist < Plus4uSearchUserMain::Errors::BaseError
      ERROR_CODE = "#{UC_CODE}/plus4uSearchUserDoesNotExist"
      MESSAGE = 'Get plus4uSearchUser by plus4uSearchUser Dao get by Awid failed.'
    end
    class Plus4uSearchUserInvalidState < Plus4uSearchUserMain::Errors::BaseError
      ERROR_CODE = "#{UC_CODE}/plus4uSearchUserInvalidState"
      MESSAGE = 'uuObject plus4uSearchUser is not in active state.'
    end
  end

  module UpdateAppListErrors
    UC_CODE = "#{Plus4uSearchUserMain::APP_CODE}/updateAppList"

    class InvalidDtoIn < Plus4uSearchUserMain::Errors::BaseError
      ERROR_CODE = "#{UC_CODE}/invalidDtoIn"
      MESSAGE = 'Invalid DtoIn.'
    end
    class Plus4uSearchUserDaoUpdateFailed  < Plus4uSearchUserMain::Errors::BaseError
      ERROR_CODE = "#{UC_CODE}/plus4uSearchUserDaoUpdateFailed"
      MESSAGE = 'Update plus4uSearchUser by plus4uSearchUser DAO updateByAwid failed.'
    end
  end

  module ListClientsByCriteriaErrors
    UC_CODE = "#{Plus4uSearchUserMain::APP_CODE}/listClientsByCriteria"

    class InvalidDtoIn < Plus4uSearchUserMain::Errors::BaseError
      ERROR_CODE = "#{UC_CODE}/invalidDtoIn"
      MESSAGE = 'Invalid DtoIn.'
    end
    class CallCmdFailed  < Plus4uSearchUserMain::Errors::BaseError
      ERROR_CODE = "#{UC_CODE}/callCmdFailed"
      MESSAGE = 'Failed to call command.'
    end
  end
end

