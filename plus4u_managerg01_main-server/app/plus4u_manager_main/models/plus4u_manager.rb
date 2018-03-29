module Plus4uManagerMain
  module Models
    class Plus4u
      include Singleton
      include Plus4uManagerMain::Config::AppConfig
      include Plus4uManagerMain::Errors::Plus4uManagerMainError
      include Plus4uManagerMain::Helpers::AppHelper

      SCHEMA = 'demo'

      VALIDATION_FILES_PATH = '/app/plus4u_manager_main/validation_types'
      PLUS4U_MANAGER_TYPES_PATH = "#{VALIDATION_FILES_PATH}/plus4u_manager_types.js"

      WARNINGS = {
          initUnsupportedKeys: {
              code: "#{APP_CODE}/init/unsupportedKeys"
          },
          loginUnsupportedKeys: {
              code: "#{APP_CODE}/login/unsupportedKeys"
          },
          listActivitiesUnsupportedKeys: {
              code: "#{APP_CODE}/listActivities/unsupportedKeys"
          },
          setStateUnsupportedKeys: {
              code: "#{APP_CODE}/setState/unsupportedKeys"
          },
          findPersonByParametersUnsupportedKeys: {
              code: "#{APP_CODE}/findPersonByParameters/unsupportedKeys"
          },
          sendMessageUnsupportedKeys: {
              code: "#{APP_CODE}/sendMessage/unsupportedKeys"
          },
          changeCredentialsUnsupportedKeys: {
              code: "#{APP_CODE}/changeCredentials/unsupportedKeys"
          },
          createActivityUnsupportedKeys: {
              code: "#{APP_CODE}/createActivity/unsupportedKeys"
          }
      }


      attr_reader :demo_dao

      def initialize
        @demo_dao = UuApp::SubAppStore::DaoFactory.get_dao(SCHEMA)
        validation_type_path = File.join(UuApp::Util::Config[:server_root], PLUS4U_MANAGER_TYPES_PATH)
        UuApp::Validation::Validator.load(validation_type_path)
      end


      def init(awid, dto_in, session, uu_app_error_map = {})
        # continue model methods here
      end

      def login(dto_in, uu_app_error_map = {})
        validation_result = UuApp::Validation::Validator.loginDtoInType.validate(dto_in)
        uu_app_error_map = UuAppWorkspace::Helper::ValidationHelper.process_validation_result(dto_in, validation_result, uu_app_error_map,
                                                                                              WARNINGS[:loginUnsupportedKeys][:code],
                                                                                              LoginErrors::InvalidDtoIn)
        begin
          result = get_login(dto_in[:code1], dto_in[:code2])
        rescue UuAppObjectStore::Error::ObjectStoreError => e
          # A1
          raise LoginErrors::InvalidCredentials.new({uuAppErrorMap: uu_app_error_map}, cause: e)
        end

        dto_out = {}
        dto_out[:state] = result
        dto_out[:uuAppErrorMap] = uu_app_error_map
        dto_out
      end

      def list_activities(dto_in, uu_app_error_map = {})
        validation_result = UuApp::Validation::Validator.listActivitiesDtoInType.validate(dto_in)
        uu_app_error_map = UuAppWorkspace::Helper::ValidationHelper.process_validation_result(dto_in, validation_result, uu_app_error_map,
                                                                                              WARNINGS[:listActivitiesUnsupportedKeys][:code],
                                                                                              ListActivitiesErrors::InvalidDtoIn)

        #login into system
        get_login(dto_in[:code1], dto_in[:code2])

        # Get UID from person URI
        name = UU::OS::Security::Session.current_session.get_personal_role
        last_part = name.to_s.split(':')
        parameter = last_part[last_part.length - 1].to_s.split('[')
        uid = parameter[0]

        territories = UU::OS::PersonalRole.get_territory_list(name)

        activities = []
        territories.each do |territory|
          activities << UU::DigitalWorkspace::DigitalWorkspace.get_active_record_list(
              "ues:#{territory.code}:#{uid}",
              :query=>"dateTo < '#{Date.today.next_month(2)}' and dateFrom > '#{Date.today.prev_day(7)}'",
              :recursive=>true
          )
        end

        sorted_activities = []
        activities.each do |territory|
          territory.each do |activity|
            sorted_activities << activity
          end
        end

        dto_out = {}
        dto_out[:activities] = sorted_activities.sort_by!{ |obj| obj.date_to }
        dto_out[:uuAppErrorMap] = uu_app_error_map
        dto_out
      end

      def find_person_by_parameters(dto_in, parameters = {}, uu_app_error_map = {})
        validation_result = UuApp::Validation::Validator.findPersonByParametersDtoInType.validate(dto_in)
        uu_app_error_map = UuAppWorkspace::Helper::ValidationHelper.process_validation_result(dto_in, validation_result, uu_app_error_map,
                                                                                              WARNINGS[:findPersonByParametersUnsupportedKeys][:code],
                                                                                              FindPersonByParameters::InvalidDtoIn)

        #login into system
        get_login(dto_in[:code1], dto_in[:code2])

        cmd = UU::OS::CMD::CommandClient.new(PEOPLE_APP_PATH, UU::OS::Security::Session.current_session, nil)

        parameters[PEOPLE_CMD_PARAMETERS[:clientName]] = dto_in[:clientName]
        result = cmd.invoke(PEOPLE_CMD_PATH, PEOPLE_CMD_UU_URI, parameters: parameters)

        dto_out = {}
        dto_out[:cardList] = result
        dto_out[:uuAppErrorMap] = uu_app_error_map
        dto_out
      end

      def send_message(dto_in, parameters = {}, uu_app_error_map = {})
        validation_result = UuApp::Validation::Validator.sendMessageDtoInType.validate(dto_in)
        error = UuAppWorkspace::Helper::ValidationHelper.process_validation_result(dto_in, validation_result, uu_app_error_map,
                                                                                   WARNINGS[:sendMessageUnsupportedKeys][:code],
                                                                                   SendMessageErrors::InvalidDtoIn)

        #login into system
        get_login(dto_in[:code1], dto_in[:code2])

        # Get UID from person URI
        name = UU::OS::Security::Session.current_session.get_personal_role
        last_part = name.to_s.split(':')
        parameter = last_part[last_part.length - 1].to_s.split('[')
        uid = parameter[0]

        cmd = UU::OS::CMD::CommandClient.new(PEOPLE_APP_PATH, UU::OS::Security::Session.current_session, nil)
        parameters[PEOPLE_CMD_PARAMETERS[:uuId]] = dto_in[:p4u_id]
        result_to = cmd.invoke(PEOPLE_CMD_PATH, PEOPLE_CMD_UU_URI, parameters: parameters)
        parameters[PEOPLE_CMD_PARAMETERS[:uuId]] = uid
        result_from = cmd.invoke(PEOPLE_CMD_PATH, PEOPLE_CMD_UU_URI, parameters: parameters)

        name_to = result_to[0][:name]
        name_from = result_from[0][:name]

        activity_create = UU::OS::Activity.create("#{dto_in[:uri]}", :name => "Zpráva (#{name_from} - #{name_to})", :executive_role_uris => ["ues:PLUS4U-BT:#{dto_in[:p4u_id]}"], :activity_type => 'MESSAGE')
        UU::OS::Activity.set_state(activity_create, :type => 'INITIAL', :comment => dto_in[:message])

        dto_out = {}
        dto_out[:activityCreated] = activity_create
        dto_out[:uuAppErrorMap] = error
        dto_out
      end

      def set_state(dto_in, uu_app_error_map = {})
        validation_result = UuApp::Validation::Validator.setStateDtoInType.validate(dto_in)
        uu_app_error_map = UuAppWorkspace::Helper::ValidationHelper.process_validation_result(dto_in, validation_result, uu_app_error_map,
                                                                                              WARNINGS[:setStateUnsupportedKeys][:code],
                                                                                              SetStateErrors::InvalidDtoIn)

        #login into system
        get_login(dto_in[:code1], dto_in[:code2])

        begin
          state = UU::OS::Activity.set_state(dto_in[:activityUri], :type => dto_in[:activityStateType], :comment => dto_in[:comment])
        rescue UuAppObjectStore::Error::ObjectStoreError => e
          raise SetStateErrors::CannotSetState.new({uuAppErrorMap: uu_app_error_map}, cause: e)
        end

        dto_out = {}
        dto_out[:setState] = state
        dto_out[:uuAppErrorMap] = uu_app_error_map
        dto_out
      end

      def get_activity_list(dto_in, uu_app_error_map = {})
        validation_result = UuApp::Validation::Validator.getActivityListDtoInType.validate(dto_in)
        uu_app_error_map = UuAppWorkspace::Helper::ValidationHelper.process_validation_result(dto_in, validation_result, uu_app_error_map,
                                                                                              WARNINGS[:listActivitiesUnsupportedKeys][:code],
                                                                                              ListActivitiesErrors::InvalidDtoIn)

        #login into system
        get_login(dto_in[:code1], dto_in[:code2])

        # Get UID from person URI
        name = UU::OS::Security::Session.current_session.get_personal_role
        last_part = name.to_s.split(':')
        parameter = last_part[last_part.length - 1].to_s.split('[')
        uid = parameter[0]

        territories = UU::OS::PersonalRole.get_territory_list(name)

        activities = []
        territories.each do |territory|
          activities << UU::DigitalWorkspace::DigitalWorkspace.get_active_record_list(
              "ues:#{territory.code}:#{uid}",
              :query=>"dateTo < '#{Date.today.next_month(3)}' and dateFrom > '#{Date.today}'",
              :recursive=>true
          )
        end

        sorted_activities = []
        activities.each do |territory|
          territory.each do |activity|
            sorted_activities << activity if activity.block_time_in_calendar
          end
        end

        #sorted_activities.sort_by!{ |obj| obj.date_to }.reverse

        dto_out = {}
        dto_out[:activities] = sorted_activities
        dto_out[:uuAppErrorMap] = uu_app_error_map
        dto_out
      end

      def change_credentials(dto_in, uu_app_error_map = {})
        validation_result = UuApp::Validation::Validator.changeCredentialsDtoInType.validate(dto_in)
        uu_app_error_map = UuAppWorkspace::Helper::ValidationHelper.process_validation_result(dto_in, validation_result, uu_app_error_map,
                                                                                              WARNINGS[:changeCredentialsUnsupportedKeys][:code],
                                                                                              ChangeCredentialsErrors::InvalidDtoIn)

        #login into system
        get_login(dto_in[:oldCode1], dto_in[:oldCode2])

        # Get UID from person URI
        name = UU::OS::Security::Session.current_session.get_personal_role
        last_part = name.to_s.split(':')
        parameter = last_part[last_part.length - 1].to_s.split('[')
        uid = parameter[0]

        UU::OS::PersonalRole.set_access-codes("ues:PLUS4U-BT:#{uid}",
                                               :access_code1 => dto_in[:oldCode1],
                                               :access_code2 => dto_in[:oldCode2],
                                               :new_access_code1 => dto_in[:newCode1],
                                               :new_access_code2 => dto_in[:newCode2]
        )

        dto_out = {}
        dto_out[:uuAppErrorMap] = uu_app_error_map
        dto_out
      end

      def create_activity(dto_in, parameters = {}, uu_app_error_map = {})
        validation_result = UuApp::Validation::Validator.createActivityDtoInType.validate(dto_in)
        #error = UuAppWorkspace::Helper::ValidationHelper.process_validation_result(dto_in, validation_result, uu_app_error_map,
         #                                                                          WARNINGS[:createActivityUnsupportedKeys][:code],
          #                                                                         CreateActivityErrors::InvalidDtoIn)

        actionType = dto_in[:action] == '0' ? false : true
        #login into system
        get_login(dto_in[:code1], dto_in[:code2])

        # Get UID from person URI
        name = UU::OS::Security::Session.current_session.get_personal_role
        last_part = name.to_s.split(':')
        parameter = last_part[last_part.length - 1].to_s.split('[')
        uid = parameter[0]

        executives = []
        index = 0

        while dto_in["executive#{index}"] != nil do
          executives << "ues:PLUS4U-BT:#{dto_in["executive#{index}"]}"
          index += 1
        end

        if actionType
          activity_create = UU::OS::Activity.create(
              "#{dto_in[:artifactUri]}",
              block_time_in_calendar: true,
              :name => dto_in[:name],
              description: dto_in[:description],
              competent_role_uri: "ues:PLUS4U-BT:#{uid}",
              :executive_role_uris => executives,
              :activity_type => 'TIME_RESERVATION',
              date_start: dto_in[:timeFrom],
              date_to: dto_in[:timeTo]
           )
        else
          # Create activity of type TASK
          activity_create = UU::OS::Activity.create(
              "#{dto_in[:artifactUri]}",
              allow_executive_role_change:true,
              allow_subactivities:true,
              competent_role_uri: "ues:PLUS4U-BT:#{uid}",
              date_from:  dto_in[:timeFrom],
              description: dto_in[:description],
              :executive_role_uris => executives,
              :activity_type => 'TASK',
              :name => dto_in[:name],
              notify:true
          )
        end


        dto_out = {}
        dto_out[:activityCreated] = activity_create
        dto_out[:uuAppErrorMap] = {}
        dto_out
      end
    end
  end
end
