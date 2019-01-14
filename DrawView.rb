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
    flag = false
    index = 0
    for i in 0..(ants.length - 1)
        if (ants[i].GetPos() == [x, y])
            return true, i
        end
    end
    return flag, index
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

tabXSize = 40;
tabYSize = 15;
numberOfAnts = 15
antMovementIterations = 20
allAntRoles = {"Warrior" => 31, "Gatherer" => 34, "Worker" => 27}
SimulateAnts(tabXSize, tabYSize, numberOfAnts, antMovementIterations, allAntRoles)