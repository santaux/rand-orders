require "rand/version"
require "rand/orders"
require "active_record"

class ActiveRecord::Relation
  include Rand::Orders::Relation
end

class ActiveRecord::Base
  extend Rand::Orders::Base
end
