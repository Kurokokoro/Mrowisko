class Ant
    def initialize(x, y, allRoles = [], antRole = "Warrior")
        @position = [x, y]
        @role = antRole
        @encounters = Hash.new
        for i in 0..(allRoles.length - 1)
            @encounters[allRoles[i]] = 0
        end
    end

    def GetPos()
        return @position
    end

    def GetRole()
        return @role
    end

    def MakeEncounter(ant)
        @encounters[ant.GetRole()] += 1
    end
    
    def MoveToPosition(newX, newY)
        @position = [newX, newY]
    end

    def MoveInRandomDirection()
        random = rand(0..1)
        pos = rand(0..1)
        if (random > 0)
            @position[pos] = @position[pos] + 1
        else
            @position[pos] = @position[pos] - 1
        end
    end
end
        