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