module Plus4uManagerMain
  module Controllers
    class ManagerController

      def init(uc_env)
        uc_env.result = Plus4uManagerMain::Models::Plus4u.instance.init(uc_env.parameters)
      end

      def login(uc_env)
        uc_env.result = Plus4uManagerMain::Models::Plus4u.instance.login(uc_env.parameters)
      end

      def send_message(uc_env)
        uc_env.result = Plus4uManagerMain::Models::Plus4u.instance.send_message(uc_env.parameters)
      end

      def list_activities(uc_env)
        uc_env.result = Plus4uManagerMain::Models::Plus4u.instance.list_activities(uc_env.parameters)
      end

      def find_person_by_parameters(uc_env)
        uc_env.result = Plus4uManagerMain::Models::Plus4u.instance.find_person_by_parameters(uc_env.parameters)
      end

      def set_state(uc_env)
        uc_env.result = Plus4uManagerMain::Models::Plus4u.instance.set_state(uc_env.parameters)
      end

      def get_activity_list(uc_env)
        uc_env.result = Plus4uManagerMain::Models::Plus4u.instance.get_activity_list(uc_env.parameters)
      end

      def change_credentials(uc_env)
        uc_env.result = Plus4uManagerMain::Models::Plus4u.instance.change_credentials(uc_env.parameters)
      end

      def create_activity(uc_env)
        uc_env.result = Plus4uManagerMain::Models::Plus4u.instance.create_activity(uc_env.parameters)
      end

      def test(uc_env)
        uc_env.result = Plus4uManagerMain::Models::Plus4u.instance.test(uc_env.parameters)
      end
    end
  end
end
