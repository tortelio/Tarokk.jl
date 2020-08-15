using Tarokk.Accessories: Deck, Card

using Tarokk.Accessories: Club, Spade, Heart, Diamond, Tarock

using Tarokk.Accessories: Ace, Jack, Knight, Queen, King

@testset "Deck" begin
    let deck = rand(Deck)
        @test deck isa Deck
        @test length(deck) == 42

        for value ∈ 1:22
            @test Card(Tarock, value) ∈ deck
        end

        for color ∈ [Club, Spade, Heart, Diamond]
            for value ∈ [Ace, Jack, Knight, Queen, King]
                @test Card(color, value) ∈ deck
            end
        end
    end
end
