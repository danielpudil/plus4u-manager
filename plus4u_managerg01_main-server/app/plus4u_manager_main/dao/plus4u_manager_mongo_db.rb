module Plus4uManagerMain
  module Dao
    class DemoMongoDB < UuAppObjectStore::MongoDB::UuObjectDao

      def create_schema
        create_index({awid: 1, _id: 1}, {unique: true})
      end

      def get(awid, id)
        find_one({ awid: awid, id: id })
      end

    end
  end
end
