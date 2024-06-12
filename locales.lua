Global("locales", {})
--create tables of each language
locales["eng_eu"]={}
locales["rus"]={}
locales["fr"]={}
locales["ger"]={}
locales["tr"]={}

-- \n is used as a newline indicator
locales["eng_eu"][ "DominionPrepText" ] = "\nDear Avarice gamers,\nDominion(s) are starting in less than 1 hour. Please prepare the following:\nPvP food of 10%'s | 3x3 vendor\nAlchemy potions +50 | Alchemy or playertrading, check Auction House\nPotents +40 | 3x3 vendor, Relic Master NPC\nMana Batteries | 3x3 vendor\nLegendary or Fabled Dragon Tears | Embrium vendor in Private Allod or at Auction House\nPvP Artifacts | PvP vendors"
locales["fr"][ "DominionPrepText" ] = "\nDear Avarice gamers,\nDominion(s) are starting in less than 1 hour. Please prepare the following:\nPvP food of 10%'s | 3x3 vendor\nAlchemy potions +50 | Alchemy or playertrading, check Auction House\nPotents +40 | 3x3 vendor, Relic Master NPC\nMana Batteries | 3x3 vendor\nLegendary or Fabled Dragon Tears | Embrium vendor in Private Allod or at Auction House\nPvP Artifacts | PvP vendors"
locales["rus"][ "DominionPrepText" ] = "\nDear Avarice gamers,\nDominion(s) are starting in less than 1 hour. Please prepare the following:\nPvP food of 10%'s | 3x3 vendor\nAlchemy potions +50 | Alchemy or playertrading, check Auction House\nPotents +40 | 3x3 vendor, Relic Master NPC\nMana Batteries | 3x3 vendor\nLegendary or Fabled Dragon Tears | Embrium vendor in Private Allod or at Auction House\nPvP Artifacts | PvP vendors"
locales["ger"][ "DominionPrepText" ] = "\nDear Avarice gamers,\nDominion(s) are starting in less than 1 hour. Please prepare the following:\nPvP food of 10%'s | 3x3 vendor\nAlchemy potions +50 | Alchemy or playertrading, check Auction House\nPotents +40 | 3x3 vendor, Relic Master NPC\nMana Batteries | 3x3 vendor\nLegendary or Fabled Dragon Tears | Embrium vendor in Private Allod or at Auction House\nPvP Artifacts | PvP vendors"
locales["tr"][ "DominionPrepText" ] = "\nDear Avarice gamers,\nDominion(s) are starting in less than 1 hour. Please prepare the following:\nPvP food of 10%'s | 3x3 vendor\nAlchemy potions +50 | Alchemy or playertrading, check Auction House\nPotents +40 | 3x3 vendor, Relic Master NPC\nMana Batteries | 3x3 vendor\nLegendary or Fabled Dragon Tears | Embrium vendor in Private Allod or at Auction House\nPvP Artifacts | PvP vendors"




locales = locales[common.GetLocalization()] -- trims all other languages except the one that common.getlocal got.