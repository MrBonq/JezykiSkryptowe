let Poz: Position = null
let i = 0
let door = 0
let VarY = 0
let z = 0
let x = 0
let y = 0
let VarX = 0
let HeightZ = 0
// Tower windows
function Window () {
    blocks.fill(IRON_BARS,positions.add(Poz,pos(8, 0, 8)),
    positions.add(positions.add(Poz,pos(8, 0, 8)),pos(4, 12, 4)),
    FillOperation.Hollow)
}
// Agent Position
function Position2 () {
    i = 0
    agent.teleportToPlayer()
    Poz = positions.add(agent.getPosition(),pos(3, 0, 3))
}
// Castle door
function Door () {
    door = Poz.getValue(Axis.X) / 2 - 1
    VarY = Poz.getValue(Axis.Y)
    z = Poz.getValue(Axis.Z)
    blocks.fill(AIR,positions.add(Poz,pos(16 / 2 - 2, 0, 0)),
    positions.add(Poz,pos(16 / 2 + 2, 6, 2)),FillOperation.Replace)
    blocks.fill(IRON_BARS,positions.add(Poz,pos(16 / 2 - 2, 4, 1)),
    positions.add(Poz,pos(16 / 2 + 2, 6, 1)),FillOperation.Replace)
}
// Tower spikes
function Kolce () {
    i = 0
    while (i < 16) {
        if (i % 2 == 0) {
            blocks.place(STONE_BRICK_MONSTER_EGG, positions.add(Poz,pos(i, 12, 0)))
            blocks.place(STONE_BRICK_MONSTER_EGG, positions.add(Poz,pos(i, 12, 16)))
            blocks.place(STONE_BRICK_MONSTER_EGG, positions.add(Poz,pos(0, 12, i)))
            blocks.place(STONE_BRICK_MONSTER_EGG, positions.add(Poz,pos(16, 12, i)))
        }
        blocks.place(OAK_FENCE, positions.add(Poz,pos(i, 12, 2)))
        blocks.place(OAK_FENCE, positions.add(Poz,pos(i, 12, 14)))
        blocks.place(OAK_FENCE, positions.add(Poz,pos(2, 12, i)))
        blocks.place(OAK_FENCE, positions.add(Poz,pos(14, 12, i)))
        i = i + 1
    }
    blocks.place(AIR, positions.add(Poz,pos(4, 12, 2)))
    blocks.place(AIR, positions.add(Poz,pos(12, 12, 2)))
}
// Tower entry
function towerEntry () {
    blocks.fill(AIR,positions.add(Poz,pos(1, 12, 1)),
    positions.add(positions.add(Poz,pos(1, 0, 1)),pos(15, 13, 0)),FillOperation.Hollow)
    blocks.fill(AIR,positions.add(Poz,pos(15, 12, 1)),
    positions.add(positions.add(Poz,pos(15, 0, 1)),pos(0, 13, 16)),FillOperation.Hollow)
    blocks.fill(AIR,positions.add(Poz,pos(1, 12, 1)),
    positions.add(positions.add(Poz,pos(1, 0, 1)),pos(0, 13, 15)),FillOperation.Replace)
    blocks.fill(AIR,positions.add(Poz,pos(1, 12, 15)),
    positions.add(positions.add(Poz,pos(1, 0, 15)),pos(15, 13, 0)),FillOperation.Replace)
}

// Tower nr2
function Sqr2 () {
    i = 0
    while (i < 5) {
        if (i % 2 == 0) {
            blocks.place(MOSSY_STONE_BRICKS, positions.add(
            positions.add(Poz,pos(14, 15, -2)),pos(i, 0, 0)))
            blocks.place(MOSSY_STONE_BRICKS, positions.add(positions.add(Poz,pos(14, 15, 2)),pos(i, 0, 0)))
            blocks.place(MOSSY_STONE_BRICKS, positions.add(positions.add(Poz,pos(14, 15, -2)),pos(0, 0, i)))
            blocks.place(MOSSY_STONE_BRICKS, positions.add(positions.add(Poz,pos(18, 15, -2)),pos(0, 0, i)))
        }
        i = i + 1
    }
    blocks.fill(MOSSY_STONE_BRICKS,positions.add(Poz,pos(14, 0, -2)),
    positions.add(positions.add(Poz,pos(14, 0, -2)),pos(4, 14, 4)),FillOperation.Hollow)
    blocks.fill(MOSSY_STONE_BRICKS,positions.add(Poz,pos(14, 11, -2)),
    positions.add(positions.add(Poz,pos(14, 0, -2)),pos(4, 11, 4)),FillOperation.Replace)
    blocks.fill(NETHER_BRICK_FENCE,positions.add(Poz,pos(16, 3, -2)),
    positions.add(Poz,pos(16, 11, -2)),FillOperation.Replace)
    blocks.fill(NETHER_BRICK_FENCE,positions.add(Poz,pos(18, 3, 0)),
    positions.add(Poz,pos(18, 11, 0)),FillOperation.Replace)
}
// Tower nr1
function Sqr1 () {
    i = 0
    while (i < 5) {
        if (i % 2 == 0) {
            blocks.place(MOSSY_STONE_BRICKS, positions.add(
            positions.add(Poz,pos(-2, 15, -2)),pos(i, 0, 0)))
            blocks.place(MOSSY_STONE_BRICKS, positions.add(
            positions.add(Poz,pos(-2, 15, 2)),pos(i, 0, 0)))
            blocks.place(MOSSY_STONE_BRICKS, positions.add(
            positions.add(Poz,pos(-2, 15, -2)),pos(0, 0, i)))
            blocks.place(MOSSY_STONE_BRICKS, positions.add(
            positions.add(Poz,pos(2, 15, -2)),pos(0, 0, i)))
        }
        i = i + 1
    }
    blocks.fill(MOSSY_STONE_BRICKS,positions.add(Poz,pos(-2, 0, -2)),
    positions.add(Poz,pos(2, 14, 2)),FillOperation.Hollow)
    blocks.fill(MOSSY_STONE_BRICKS,positions.add(Poz,pos(-2, 11, -2)),
    positions.add(Poz,pos(2, 11, 2)),FillOperation.Replace)
    blocks.fill(NETHER_BRICK_FENCE,positions.add(Poz,pos(-2, 3, 0)),
    positions.add(Poz,pos(-2, 11, 0)),FillOperation.Replace)
    blocks.fill(NETHER_BRICK_FENCE,positions.add(Poz,pos(0, 3, -2)),
    positions.add(Poz,pos(0, 11, -2)),FillOperation.Replace)
}
// Tower Center
function SqrCenter () {
    x = Poz.getValue(Axis.X)
    y = Poz.getValue(Axis.Y)
    z = Poz.getValue(Axis.Z)
    VarX = x + 16
    VarY = y + 16
    HeightZ = z + 13
    blocks.fill(WATER,positions.add(Poz,pos(-8, -1, -8)),
    positions.add(Poz,pos(24, -3, 24)),FillOperation.Replace)
    blocks.fill(DARK_PRISMARINE,positions.add(Poz,pos(-4, -1, -4)),
    positions.add(Poz,pos(20, -3, 20)),FillOperation.Replace)
    blocks.fill(STONE_BRICK_MONSTER_EGG,Poz,positions.add(Poz,pos(16, 11, 16)),FillOperation.Replace)
    blocks.fill(AIR,positions.add(Poz,pos(3, 0, 3)),
    positions.add(Poz,pos(13, 13, 13)),FillOperation.Replace)
    blocks.fill(STONE_BRICK_MONSTER_EGG,positions.add(Poz,pos(3, 8, 3)),
    positions.add(Poz,pos(13, 8, 13)),FillOperation.Replace)
    blocks.fill(OAK_FENCE,positions.add(Poz,pos(5, 9, 5)),
    positions.add(Poz,pos(11, 9, 11)),FillOperation.Replace)
    blocks.fill(AIR,positions.add(Poz,pos(6, 8, 6)),
    positions.add(Poz,pos(10, 9, 10)),FillOperation.Replace)
    blocks.fill(LADDER,positions.add(Poz,pos(4, 0, 3)),
    positions.add(Poz,pos(4, 11, 3)),FillOperation.Replace)
    blocks.fill(LADDER,positions.add(Poz,pos(12, 0, 3)),
    positions.add(Poz,pos(12, 11, 3)),FillOperation.Replace)
}
// Tower nr4
function Sqr4 () {
    i = 0
    while (i < 5) {
        if (i % 2 == 0) {
            blocks.place(MOSSY_STONE_BRICKS, positions.add(positions.add(Poz,pos(-2, 15, 14)),pos(i, 0, 0)))
            blocks.place(MOSSY_STONE_BRICKS, positions.add(positions.add(Poz,pos(-2, 15, 18)),pos(i, 0, 0)))
            blocks.place(MOSSY_STONE_BRICKS, positions.add(positions.add(Poz,pos(-2, 15, 14)),pos(0, 0, i)))
            blocks.place(MOSSY_STONE_BRICKS, positions.add(positions.add(Poz,pos(2, 15, 14)),pos(0, 0, i)))
        }
        i = i + 1
    }
    blocks.fill(MOSSY_STONE_BRICKS,positions.add(Poz,pos(2, 0, 14)),
    positions.add(positions.add(Poz,pos(2, 0, 14)),pos(-4, 14, 4)),FillOperation.Hollow)
    blocks.fill(MOSSY_STONE_BRICKS,positions.add(Poz,pos(2, 11, 14)),
    positions.add(positions.add(Poz,pos(2, 0, 14)),pos(-4, 11, 4)),FillOperation.Replace)
    blocks.fill(NETHER_BRICK_FENCE,positions.add(Poz,pos(0, 3, 18)),
    positions.add(Poz,pos(0, 11, 18)),FillOperation.Replace)
    blocks.fill(NETHER_BRICK_FENCE,positions.add(Poz,pos(-2, 3, 16)),
    positions.add(Poz,pos(-2, 11, 16)),FillOperation.Replace)
}
// Moat
function Fosa () {
    blocks.fill(PRISMARINE_BRICKS,positions.add(Poz,pos(16 / 2 - 2, 0, -4)),
    positions.add(Poz,pos(16 / 2 + 2, 0, -9)),FillOperation.Replace)
    blocks.fill(PRISMARINE_BRICK_SLAB,positions.add(Poz,pos(16 / 2 - 1, 0, -4)),
    positions.add(Poz,pos(16 / 2 + 1, 0, -4)),FillOperation.Replace)
    blocks.fill(PRISMARINE_BRICK_SLAB,positions.add(Poz,pos(16 / 2 - 1, 0, -9)),
    positions.add(Poz,pos(16 / 2 + 1, 0, -9)),FillOperation.Replace)
    blocks.fill(MOSSY_COBBLESTONE_WALL,positions.add(Poz,pos(16 / 2 - 2, 1, -4)),
    positions.add(Poz,pos(16 / 2 - 2, 1, -9)),FillOperation.Replace)
    blocks.fill(MOSSY_COBBLESTONE_WALL,positions.add(Poz,pos(16 / 2 + 2, 1, -4)),
    positions.add(Poz,pos(16 / 2 + 2, 1, -9)),FillOperation.Replace)
}
// Tower nr3
function Sqr3 () {
    i = 0
    while (i < 5) {
        if (i % 2 == 0) {
            blocks.place(MOSSY_STONE_BRICKS, positions.add(
            positions.add(Poz,pos(14, 15, 14)),pos(i, 0, 0)))
            blocks.place(MOSSY_STONE_BRICKS, positions.add(
            positions.add(Poz,pos(14, 15, 18)),pos(i, 0, 0)))
            blocks.place(MOSSY_STONE_BRICKS, positions.add(
            positions.add(Poz,pos(14, 15, 14)),pos(0, 0, i)))
            blocks.place(MOSSY_STONE_BRICKS, positions.add(
            positions.add(Poz,pos(18, 15, 14)),pos(0, 0, i)))
        }
        i = i + 1
        blocks.fill(MOSSY_STONE_BRICKS,positions.add(Poz,pos(14, 0, 14)),
        positions.add(positions.add(Poz,pos(14, 0, 14)),pos(4, 14, 4)),FillOperation.Hollow)
        blocks.fill(MOSSY_STONE_BRICKS,positions.add(Poz,pos(14, 11, 14)),
        positions.add(positions.add(Poz,pos(14, 0, 14)),pos(4, 11, 4)),FillOperation.Replace)
        blocks.fill(NETHER_BRICK_FENCE,positions.add(Poz,pos(16, 3, 18)),
        positions.add(Poz,pos(16, 11, 18)),FillOperation.Replace)
        blocks.fill(NETHER_BRICK_FENCE,positions.add(Poz,pos(18, 3, 16)),
        positions.add(Poz,pos(18, 11, 16)),FillOperation.Replace)
    }
}

//Use diamod to build castle
player.onItemInteracted(DIAMOND, function () {
    Position2()
    SqrCenter()
    Fosa()
    Kolce()
    Sqr1()
    Sqr2()
    Sqr3()
    Sqr4()
    Door()
    towerEntry()
})
