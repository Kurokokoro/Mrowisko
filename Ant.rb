class Ant
    def initialize(x, y, all_roles = [], ant_role = "Warrior")
        @position = [x, y]
        @role = ant_role
        @encounters = Hash.new
        for i in 0..(all_roles.length - 1)
            @encounters[all_roles[i]] = 0
        end
    end

    def get_position()
        return @position
    end

    def get_role()
        return @role
    end

    def make_encounter(ant)
        @encounters[ant.get_role()] += 1
    end
    
    def move_to_position(new_x, new_y)
        @position = [new_x, new_y]
    end

    def move_in_random_direction()
        random = rand(0..1)
        position = rand(0..1)
        if (random > 0)
            @position[position] = @position[position] + 1
        else
            @position[position] = @position[position] - 1
        end
    end
end
