require './Ant'
require './DrawAnts'

RED = "31"
BLUE = "34"
WHITE = "27"
ALL_ANTS_ROLES = {"Warrior" => RED, "Gatherer" => BLUE, "Worker" => WHITE}

SLEEP_TIME = 0.3

tab_x_size = 40
tab_y_size = 15
number_of_ants = 15
ant_movement_iteration = 20

def generate_new_ant_on_border(x_size, y_size)
    rand_y = rand(y_size)
    if (rand_y == 0 || rand_y == (y_size - 1))
        rand_x = rand(x_size)
    else
        rand_x = rand(0..1)
        if (rand_x == 1)
            rand_x = x_size - 1
        end
    end
    return Ant.new(rand_x, rand_y, ALL_ANTS_ROLES.keys)
end

def has_ant_crossed_border(ant, x_size, y_size)
    if (ant.get_position()[0] >= x_size || ant.get_position()[0] <= 0) ||
        (ant.get_position()[1] >= y_size || ant.get_position()[1] <= 0)
        return true
    else
        return false
    end
end

def create_ants(tab_x_size, tab_y_size, number_of_ants)
    ant_tab = []
    for i in 1..number_of_ants
        ant = Ant.new(rand(tab_x_size), rand(tab_y_size), ALL_ANTS_ROLES.keys)
        ant_tab.push(ant)
    end
    return ant_tab
end

def simulate_ants(tab_x_size, tab_y_size, number_of_ants, ant_movement_iteration)
    ant_tab = create_ants(tab_x_size, tab_y_size, number_of_ants)
    for i in 1..ant_movement_iteration
        print_to_treminal(ant_tab, tab_x_size, tab_y_size)
        for j in 0..(ant_tab.length - 1)
            ant_tab[j].move_randomly()
            if (has_ant_crossed_border(ant_tab[j], tab_x_size, tab_y_size))
              ant_tab[j] = generate_new_ant_on_border(tab_x_size, tab_y_size)
            end
        end
        sleep(SLEEP_TIME)
    end
    print "#{CSI}[#{tab_y_size}B"
end


simulate_ants(tab_x_size, tab_y_size, number_of_ants, ant_movement_iteration)