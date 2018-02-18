module UuDemoappMain
  module Models
    class Demo
      include Singleton

      SCHEMA = 'demo'

      VALIDATION_FILES_PATH = '/app/uu_demoapp_main/validation_types'
      DEMO_TYPES_PATH = "#{VALIDATION_FILES_PATH}/demo_types.js"


      attr_reader :demo_dao

      def initialize
        @demo_dao = UuApp::SubAppStore::DaoFactory.get_dao(SCHEMA)
        validation_type_path = File.join(UuApp::Util::Config[:server_root], DEMO_TYPES_PATH)
        UuApp::Validation::Validator.load(validation_type_path)
      end


      def init(awid, dto_in, session, uu_app_error_map = {})
        # continue model methods here
      end

      def load_demo_content(awid, dto_in, session)
        # continue model methods here
        dto_out = {
          title: {
            cs: "Zkušební data",
            en: "Testing data"
          },
          name: "<uu5string/><UU5.Bricks.Lsi><UU5.Bricks.Lsi.Item language='cs'>Zkušební data</UU5.Bricks.Lsi.Item><UU5.Bricks.Lsi.Item language='en'>Testing data</UU5.Bricks.Lsi.Item></UU5.Bricks.Lsi>",
          description: "<uu5string/><UU5.Bricks.Lsi><UU5.Bricks.Lsi.Item language='cs'><UU5.Bricks.P>Testovací mock data, které jsou čteny ze serveru.</UU5.Bricks.P></UU5.Bricks.Lsi.Item><UU5.Bricks.Lsi.Item language='en'><UU5.Bricks.P>Testing mock data loaded from server.</UU5.Bricks.P></UU5.Bricks.Lsi.Item></UU5.Bricks.Lsi>",
          languages: ["cs", "en"]
        }
        dto_out[:uuAppErrorMap] = {}
        dto_out
      end

    end
  end
end
