module UuDemoappMain
  module Controllers
    class DemoController

      def init(uc_env)
        uc_env.result = UuDemoappMain::Models::Demo.instance.init(uc_env.uri.awid, uc_env.parameters, uc_env.session)
      end

      def load_demo_content(uc_env)
        uc_env.result = UuDemoappMain::Models::Demo.instance.load_demo_content(uc_env.uri.awid, uc_env.parameters, uc_env.session)
      end

    end
  end
end
