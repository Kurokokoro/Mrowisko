require './Ant'

def PrintToTerminal(ants, xSize, ySize, allAntRoles)
    pos = ySize
    antSymbol = "\u{1F41C}"
    for y in 0..(ySize - 1)
        print "\033[K"
        for x in 0..(xSize - 1)
            flag, index = CheckAntPos(ants, x, y)
            if (flag)
                print "\e[#{allAntRoles[ants[index].GetRole()]}m#{antSymbol}\e[0m"
            else
                print " "
            end
        end
        print "\n"
    end
    print "\033[#{pos}A"
end

def CheckAntPos(ants, x, y)
    for i in 0..(ants.length - 1)
        if (ants[i].GetPos() == [x, y])
            return true, i
        end
    end
    return false, 0
end

def GenetarteNewBorderAnt(xSize, ySize)
    randY = rand(ySize)
    if (randY == 0 || randY == (ySize - 1))
        randX = rand(xSize)
    else
        randX = rand(0..1)
        if (randX == 1)
            randX = xSize - 1
        end
    end
    return Ant.new(randX, randY)
end

def SimulateAnts(tabXSize, tabYSize, numberOfAnts, antMovementIterations, allAntRoles)
    antTab = []
    for i in 1..numberOfAnts
        ant = Ant.new(rand(tabXSize), rand(tabYSize), allAntRoles.keys, allAntRoles.keys[rand(allAntRoles.length)])
        antTab.push(ant)
    end
    for i in 1..antMovementIterations
        PrintToTerminal(antTab, tabXSize, tabYSize, allAntRoles)
        for j in 0..(antTab.length - 1)
            antTab[j].MoveInRandomDirection()
            if (antTab[j].GetPos()[0] >= tabXSize || antTab[j].GetPos()[0] <= 0) ||
            (antTab[j].GetPos()[1] >= tabYSize || antTab[j].GetPos()[1] <= 0)
            antTab[j] = GenetarteNewBorderAnt(tabXSize, tabYSize)
            end
        end
        sleep(0.3)
    end
    print "\033[#{tabYSize}B"
end

class String
    def black;          "\e[30m#{self}\e[0m" end
    def red;            "\e[31m#{self}\e[0m" end
    def green;          "\e[32m#{self}\e[0m" end
    def brown;          "\e[33m#{self}\e[0m" end
    def blue;           "\e[34m#{self}\e[0m" end
    def magenta;        "\e[35m#{self}\e[0m" end
    def cyan;           "\e[36m#{self}\e[0m" end
    def gray;           "\e[37m#{self}\e[0m" end
    
    def bg_black;       "\e[40m#{self}\e[0m" end
    def bg_red;         "\e[41m#{self}\e[0m" end
    def bg_green;       "\e[42m#{self}\e[0m" end
    def bg_brown;       "\e[43m#{self}\e[0m" end
    def bg_blue;        "\e[44m#{self}\e[0m" end
    def bg_magenta;     "\e[45m#{self}\e[0m" end
    def bg_cyan;        "\e[46m#{self}\e[0m" end
    def bg_gray;        "\e[47m#{self}\e[0m" end
    
    def bold;           "\e[1m#{self}\e[22m" end
    def italic;         "\e[3m#{self}\e[23m" end
    def underline;      "\e[4m#{self}\e[24m" end
    def blink;          "\e[5m#{self}\e[25m" end
    def reverse_color;  "\e[7m#{self}\e[27m" end
    end


tabXSize = 40;
tabYSize = 15;
numberOfAnts = 15
antMovementIterations = 20
allAntRoles = {"Warrior" => 31, "Gatherer" => 34, "Worker" => 27}
SimulateAnts(tabXSize, tabYSize, numberOfAnts, antMovementIterations, allAntRoles)