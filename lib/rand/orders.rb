module Rand
  module Orders
    module Relation
      def random
        relation = clone
        relation.order_values += [random_clause]
        relation
      end

      def random_in_range(field_name, range)
        relation = random
        relation.where_values += build_where("#{field_name} > #{range.min} AND #{field_name} < #{range.max}", [])
        relation
      end

      def random_equal(field_name, value)
        relation = random
        relation.where_values += build_where({field_name.to_sym => value}, [])
        relation
      end

      def select_random(field_name)
        random.pluck(field_name)
      end

      def random_clause
        case connection.adapter_name
          when /mysql/i
            'RAND()'
          when /sqlite|postgres/i
            'RANDOM()'
          else
            raise "Rand::Orders Error: Unknown adapter!"
        end
      end
    end

    module Base
      def random
        relation.random
      end

      def random_in_range(field_name, range)
        relation.random_in_range(field_name, range)
      end

      def random_equal(field_name, value)
        relation.random_equal(field_name, value)
      end

      def select_random(field_name)
        relation.select_random(field_name)
      end
    end
  end
end
