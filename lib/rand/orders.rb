module Rand
  module Orders
    module Relation
      # Returns randomly sorted records from database.
      #
      # @example Item.where(:user_id => 1).random
      def random
        relation = clone
        relation.order_values += [random_clause]
        relation
      end

      # Returns randomly sorted records from database with field value
      # in specified range.
      #
      # @param [String, Symbol] field_name a name of the field
      # @param [Range] range range object with MIN and MAX values for specified field.
      #
      # @example Item.random_in_range(:amount, (2..5)).limit(10)
      def random_in_range(field_name, range)
        relation = random
        relation.where_values += build_where("#{field_name} > #{range.min} AND #{field_name} < #{range.max}", [])
        relation
      end

      # Returns randomly sorted records from database with field value
      # equal to specified parameter.
      #
      # @param [String, Symbol] field_name a name of the field or range comparing.
      # @param value a value of the specified field.
      #
      # @example Item.random_equal(:user_id, 1)
      def random_equal(field_name, value)
        relation = random
        relation.where_values += build_where({field_name.to_sym => value}, [])
        relation
      end

      # Returns randomly sorted array of specified field values.
      #
      # @param [String, Symbol] field_name a name of the field to return
      #
      # @example Item.select_random(:amount)
      def select_random(field_name)
        random.pluck(field_name)
      end

      # Sets random clause for each database.
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
