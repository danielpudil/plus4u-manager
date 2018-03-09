module Plus4uSearchUserMain
  module Config

    # Module for application wise configurations
    module AppConfig

      STATES = {
        active: 'active',
        uninitialized: 'uninitialized',
        initializing: 'initializing',
        initialized: 'initialized'
      }

      PROFILES = {
        authorities: 'Authorities',
        executives: 'Executives'
      }

      COMMON_ROLES = {
        ggplus4u: 'urn:uu:GGPLUS4U',
        ggall: 'urn:uu:GGALL'
      }

      DEFAULT_PAGE_INDEX = 0
      DEFAULT_PAGE_SIZE = 100

      DEFAULT_PAGE_INFO = {
        pageIndex: DEFAULT_PAGE_INDEX,
        pageSize: DEFAULT_PAGE_SIZE
      }

      PEOPLE_CMD_PARAMETERS = {
        uuId: 'p4u_id',
        clientName: 'name',
        registrationMail: 'email'
      }

      PEOPLE_APP_PATH = 'uu-plus4uppl'
      PEOPLE_CMD_PATH = 'PersonalCard/getCardList'
      PEOPLE_CMD_UU_URI = 'ues:PLUS4U-BT:PLUS4U-BT'
    end

  end
end
