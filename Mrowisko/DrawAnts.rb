CLEARLINE = "\033[K"
CSI = "\033" #CONTROL_SEQUENCE_INTRODUCER 
ANT_SYMBOL = "\u{1F41C}"

def print_to_treminal(ants, x_size, y_size)
    position = y_size
    for y in 0..(y_size - 1)
        print "#{CLEARLINE}"
        for x in 0..(x_size - 1)
            flag, index = check_ant_position(ants, x, y)
            if (flag)
                print "\e[#{ALL_ANTS_ROLES[ants[index].get_role()]}m#{ANT_SYMBOL}\e[0m"
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
            check_ant_encounter(ants, i, x, y)
            if (flag == true)
                while (ants[i].get_position() == [x, y])
                    ants[i].move_randomly()
                end
            else
                flag = true
                index = i
            end
        end
    end
    return flag, index
end

def check_ant_encounter(ants, ant_idx, ant_x, ant_y)
    for i in 0..(ants.length - 1) 
        if (i == ant_idx)
            next
        end
        for x in -1..1
            for y in -1..1
                if (ants[i].get_position() == [ant_x + x, ant_y + y])
                    ants[ant_idx].make_encounter(ants[i])
                end
            end
        end
    end
end