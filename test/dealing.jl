using Tarokk.Accessories: Deck, shuffle!, cut!, append!, take!

@testset "Dealing" begin
    let deck = Deck()
        @test deck isa Deck
        @test length(deck) == 42

        # Phase 0 -- shuffle
        shuffle!(deck)
        @test deck isa Deck
        @test length(deck) == 42

        # Phase 1 -- cut
        # Phase 1.1 -- cut the top of the deck
        cut = cut!(deck, 10)
        @test cut isa Deck
        @test length(cut) == 10
        @test deck isa Deck
        @test length(deck) == 32

        # Phase 1.2 -- put to the bottom
        append!(deck, cut)
        @test deck isa Deck
        @test length(deck) == 42

        # Phase 2 -- deal
        users = Dict(user => Card[] for user in 1:4)

        # Phase 2.1 -- dealing 4 cards for all 4 players
        for user in 1:4
            let cards = take!(deck, 4)
                @test cards isa Vector{<: Card}
                @test length(cards) == 4
                append!(users[user], cards)
            end
        end

        # Phase 2.2 -- dealing 5 cards for all 4 players
        for user in 1:4
            let cards = take!(deck, 5)
                @test cards isa Vector{<: Card}
                @test length(cards) == 5
                append!(users[user], cards)
            end
        end

        # Phase 2.3 -- dealing 6 cards to talon
        talon = take!(deck, 6)
        @test talon isa Vector{<: Card}
        @test length(talon) == 6

        @test isempty(deck)

        @info "Dealt" users talon
    end
end
