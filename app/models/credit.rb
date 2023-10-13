class Credit < ApplicationRecord
    self.inheritance_column = :my_type
end
