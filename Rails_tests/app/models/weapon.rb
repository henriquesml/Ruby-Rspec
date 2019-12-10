class Weapon < ApplicationRecord
    enum name: [ :faca, :machado, :espada ]

    validates :power_base, numericality: { greater_than: 0, less_than_or_equal_to: 100 }
    validates :level, numericality: { greater_than: 0, less_than_or_equal_to: 10 }
    validates :power_step, numericality: { greater_than: 10, less_than_or_equal_to: 100 }

    def current_power
        "#{self.power_base + ((self.level - 1) * self.power_step )}"
    end

    def title
        "#{self.name} ##{self.level}"
    end

end
