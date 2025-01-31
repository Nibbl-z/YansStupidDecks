SMODS.Atlas {
    key = "yan_decks",
    px = 69,
    py = 93,
    path = {
        ["default"] = "yan_decks.png"
    }
}

SMODS.Back {
    key = "void",
    config = {hands = -2, joker_slot = 2},
    loc_txt = {
        name = "Void Deck",
        text = {
            "{C:attention}+#1#{} Joker slots",
            "{C:blue}#2#{} hands",
            "per round"
        }
    },
    atlas = "yan_decks",
    loc_vars = function(self)
        return { vars = { self.config.joker_slot, self.config.hands } }
    end
}

SMODS.Back {
    key = "populated",
    loc_txt = {
        name = "Populated Deck",
        text = {
            "Start run with",
            "only {C:attention}Face Cards{}",
            "in your deck"
        }
    },
    atlas = "yan_decks",
    pos = { x = 1, y = 0 },
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function ()
                for _, card in ipairs(G.playing_cards) do
                    local suit_prefix = string.sub(card.base.suit, 1, 1)..'_'
                    local rank_suffix = card.base.id == 14 and 2 or math.min(card.base.id, 14)

                    if rank_suffix >= 2 and rank_suffix <= 4 or rank_suffix == 11 then
                        rank_suffix = "J"
                    elseif rank_suffix >= 5 and rank_suffix <= 7 or rank_suffix == 12 then
                        rank_suffix = "Q"
                    elseif rank_suffix >= 8 and rank_suffix <= 10 or rank_suffix == 14 or rank_suffix == 13 then
                        rank_suffix = "K"
                    end

                    card:set_base(G.P_CARDS[suit_prefix..rank_suffix])
                end

                return true
            end
        }))
    end
}

