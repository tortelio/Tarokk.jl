using Test

using Random: seed!

using Tarokk: Deck, Player, Game
using Tarokk: take_places!, shuffle_deck!, deal!
using Tarokk: dealer

@testset "Basics" begin
    seed!(2)

        # Step 0 -- Initalize
    let deck = Deck(),
        playerA = Player(name = "A"),
        playerB = Player(name = "B"),
        playerC = Player(name = "C"),
        playerD = Player(name = "D"),
        game = Game(deck = deck, players = (playerA, playerB, playerC, playerD))

        # Step 1 -- take places
        game |> take_places!
        @test dealer(game) == playerA

        # Step 2 -- shuffle deck
        game |> shuffle_deck!

        # Step 3 -- deal
        game |> deal!

        @test isempty(deck)
        @test length(game.talon) == 6
        @test length(playerA.cards) == 9
        @test length(playerB.cards) == 9
        @test length(playerC.cards) == 9
        @test length(playerD.cards) == 9

        @info "Dealt" game

        # Step 4 -- licits
        game |>
            licit!(playerA, nothing)    |>
            licit!(playerB, 3)          |>
            licit!(playerC, nothing)    |>
            licit!(playerD, 3)          |>
            licit!(playerB, nothing)

        # Further steps...
    end
end

include("accessories.jl")
include("dealing.jl")
