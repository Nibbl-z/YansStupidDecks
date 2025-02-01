SMODS.Atlas {
    key = "yan_decks",
    px = 71,
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

SMODS.Back {
    key = "super_ultra_hyper",
    loc_txt = {
        name = "SUPER ULTRA HYPER DECK!!!",
        text = {
            "{C:attention}EVERY NUMBER IS{}",
            "{C:attention}MULTIPLIED BY{}",
            "{C:attention}TEN!!!!!!!{}",
            "{C:red}(ALSO THIS DECK IS){}",
            "{C:red}UNFINISHED AND UNSTABLE SORRY{}"
        }
    },
    config = {hands = 36, joker_slot = 45, discards = 27, dollars = 36, consumable_slot = 18, hand_size = 72, ante_scaling = 10},
    atlas = "yan_decks",
    pos = { x = 2, y = 0 },
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function ()
                for _, card in ipairs(G.playing_cards) do
                    local rank = card.base.id
                    
                    if rank >= 11 and rank <= 13 then
                        rank = 10
                    end
                    
                    card.base.nominal = rank * 10
                end
                
                G.GAME.shop.joker_max = 20
                G.GAME.win_ante = 80
                G.GAME.ante_minus = 10
                G.GAME.interest_cap = 250
                G.GAME.base_reroll_cost = 50
                G.GAME.pack_size = 20
                
                for _, hand in pairs(G.GAME.hands) do
                    hand.mult = hand.mult * 10
                    hand.chips = hand.chips * 10
                    hand.s_mult = hand.s_mult * 10
                    hand.s_chips = hand.s_chips * 10
                    hand.l_mult = hand.l_mult * 10
                    hand.l_chips = hand.l_chips * 10
                end
                
                print(G.load_shop_jokers)
                
                return true
            end
        }))
        
        local shopEvent

        shopEvent = Event {
            func = function()
                if G.shop_jokers == nil then return false end
                if G.shop_jokers.cards == nil then return false end
                if #G.shop_jokers.cards == 0 then return false end
                
                G.shop_jokers.T.w = G.GAME.shop.joker_max*0.25*G.CARD_W
                G.shop:recalculate()

                return true
            end,

            blocking = false,
        }

        G.E_MANAGER:add_event(Event{
            func = function ()
                if G.shop_booster == nil then return false end
                if G.shop_booster.cards == nil then return false end
                if #G.shop_booster.cards == 0 then return false end
                
                for _, card in ipairs(G.shop_booster.cards) do
                    card.ability.extra = 20
                    
                end
            end,

            blocking = false
        })

        G.E_MANAGER:add_event(Event{
            func = function ()
                if G.pack_cards == nil then return false end
                if G.pack_cards.cards == nil then return false end
                if #G.pack_cards.cards == 0 then return false end
                
                G.pack_cards.T.w = 20*0.5*G.CARD_W
                G.pack_cards.T.x = 800

                print(G.jokers.cards)

                return true
            end,
            
            blocking = false
        })
        
        G.E_MANAGER:add_event(shopEvent)
    end
}

SMODS.Back {
    key = "solid_red",
    loc_txt = {
        name = "Solid Red Deck",
        text = {
            "Start run with",
            "{C:attention}52{}{C:hearts} Hearts{} in deck",
        }
    },
    atlas = "yan_decks",
    pos = { x = 3, y = 0 },
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function ()
                for _, card in ipairs(G.playing_cards) do
                    local suit_prefix = 'H_'
                    local rank_suffix = card.base.id

                    if rank_suffix == 10 then rank_suffix = "T" end
                    if rank_suffix == 11 then rank_suffix = "J" end
                    if rank_suffix == 12 then rank_suffix = "Q" end
                    if rank_suffix == 13 then rank_suffix = "K" end
                    if rank_suffix == 14 then rank_suffix = "A" end
                    card:set_base(G.P_CARDS[suit_prefix..rank_suffix])
                end

                return true
            end
        }))
    end
}