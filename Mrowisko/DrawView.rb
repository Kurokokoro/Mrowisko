require './Ant'

CLEARLINE = "\033[K"
CSI = "\033" #CONTROL_SEQUENCE_INTRODUCER 
RED = "31"
BLUE = "34"
WHITE = "27"
ALL_ANTS_ROLES = {"Warrior" => RED, "Gatherer" => BLUE, "Worker" => WHITE}

tab_x_size = 40
tab_y_size = 15
number_of_ants = 15
ant_movement_iteration = 20

def print_to_treminal(ants, x_size, y_size)
    position = y_size
    ant_symbol = "\u{1F41C}"
    for y in 0..(y_size - 1)
        print "#{CLEARLINE}"
        for x in 0..(x_size - 1)
            flag, index = check_ant_position(ants, x, y)
            if (flag)
                print "\e[#{ALL_ANTS_ROLES[ants[index].get_role()]}m#{ant_symbol}\e[0m"
            else
                print " "
            end
        end
        print "\n"
    end
    print "#{CSI}[#{position}A"
end

def check_ant_position(ants, x, y)
    flag = false
    index = 0
    for i in 0..(ants.length - 1)
        if (ants[i].get_position() == [x, y])
            return true, i
        end
    end
    return flag, index
end

def generate_new_border_ant(x_size, y_size)
    rand_y = rand(y_size)
    if (rand_y == 0 || rand_y == (y_size - 1))
        rand_x = rand(x_size)
    else
        rand_x = rand(0..1)
        if (rand_x == 1)
            rand_x = x_size - 1
        end
    end
    return Ant.new(rand_x, rand_y)
end

def simulate_ants(tab_x_size, tab_y_size, number_of_ants, ant_movement_iteration)
    ant_tab = []
    for i in 1..number_of_ants
        ant = Ant.new(rand(tab_x_size), rand(tab_y_size), ALL_ANTS_ROLES.keys, ALL_ANTS_ROLES.keys[rand(ALL_ANTS_ROLES.length)])
        ant_tab.push(ant)
    end
    for i in 1..ant_movement_iteration
        print_to_treminal(ant_tab, tab_x_size, tab_y_size)
        for j in 0..(ant_tab.length - 1)
            ant_tab[j].move_in_random_direction()
            if (ant_tab[j].get_position()[0] >= tab_x_size || ant_tab[j].get_position()[0] <= 0) ||
            (ant_tab[j].get_position()[1] >= tab_y_size || ant_tab[j].get_position()[1] <= 0)
            ant_tab[j] = generate_new_border_ant(tab_x_size, tab_y_size)
            end
        end
        sleep(0.3)
    end
    print "#{CSI}[#{tab_y_size}B"
end

simulate_ants(tab_x_size, tab_y_size, number_of_ants, ant_movement_iteration)