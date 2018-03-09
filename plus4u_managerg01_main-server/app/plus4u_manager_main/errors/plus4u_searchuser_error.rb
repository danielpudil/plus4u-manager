module Plus4uManagerMain
  module Errors
    module Plus4uManagerMainError

    end
  end
end

module Plus4uManagerMain::Errors::Plus4uManagerMainError
  module LoginErrors
    UC_CODE = "#{Plus4uManagerMain::APP_CODE}/login"

    class InvalidDtoIn < Plus4uManagerMain::Errors::BaseError
      ERROR_CODE = "#{UC_CODE}/invalidDtoIn"
      MESSAGE = 'Invalid DtoIn.'
    end
    class InvalidCredentials < Plus4uManagerMain::Errors::BaseError
      ERROR_CODE = "#{UC_CODE}/invalidCredentials"
      MESSAGE = 'Invalid credentials.'
    end
  end

  module ListActivitiesErrors
    UC_CODE = "#{Plus4uManagerMain::APP_CODE}/login"

    class InvalidDtoIn < Plus4uManagerMain::Errors::BaseError
      ERROR_CODE = "#{UC_CODE}/invalidDtoIn"
      MESSAGE = 'Invalid DtoIn.'
    end
    class InvalidCredentials < Plus4uManagerMain::Errors::BaseError
      ERROR_CODE = "#{UC_CODE}/invalidCredentials"
      MESSAGE = 'Invalid credentials.'
    end
  end

  module SetStateErrors
    UC_CODE = "#{Plus4uManagerMain::APP_CODE}/login"

    class InvalidDtoIn < Plus4uManagerMain::Errors::BaseError
      ERROR_CODE = "#{UC_CODE}/invalidDtoIn"
      MESSAGE = 'Invalid DtoIn.'
    end
    class InvalidCredentials < Plus4uManagerMain::Errors::BaseError
      ERROR_CODE = "#{UC_CODE}/invalidCredentials"
      MESSAGE = 'Invalid credentials.'
    end
    class CannotSetState < Plus4uManagerMain::Errors::BaseError
      ERROR_CODE = "#{UC_CODE}/cannotSetState"
      MESSAGE = 'Cannot set state of activity.'
    end
  end

  module FindPersonByParameters
    UC_CODE = "#{Plus4uManagerMain::APP_CODE}/findPersonByParameters"

    class InvalidDtoIn < Plus4uManagerMain::Errors::BaseError
      ERROR_CODE = "#{UC_CODE}/invalidDtoIn"
      MESSAGE = 'Invalid DtoIn.'
    end
  end

  module SendMessageErrors
    UC_CODE = "#{Plus4uManagerMain::APP_CODE}/sendMessage"

    class InvalidDtoIn < Plus4uManagerMain::Errors::BaseError
      ERROR_CODE = "#{UC_CODE}/invalidDtoIn"
      MESSAGE = 'Invalid DtoIn.'
    end
  end
end

