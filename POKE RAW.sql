-- Ability Flattened
SELECT
  id,name,
  a.value:ability.name::STRING AS ability_name,
  a.value:ability.url::STRING AS ability_url,
  a.value:is_hidden::BOOLEAN AS is_hidden,
  a.value:slot::INT AS slot
  from POKEDB.GIT.POKE_DETAIL poke_det
  ,
        LATERAL FLATTEN( input => PARSE_JSON(REPLACE(REPLACE(REPLACE(REPLACE(poke_det.abilities, 'True', 'true'), 'False', 'false'), 'None', 'null'), '''', '"')) ) a

-- CRY Flattened
 SELECT
  id,name,
  PARSE_JSON(REPLACE(REPLACE(REPLACE(REPLACE(poke_det.cries, 'True', 'true'), 'False', 'false'),
  'None', 'null'), '''', '"')):latest::STRING  AS cry_latest,        -- 'latest' or 'legacy'
  PARSE_JSON(REPLACE(REPLACE(REPLACE(REPLACE(poke_det.cries, 'True', 'true'), 'False', 'false'),
  'None', 'null'), '''', '"')):legacy::STRING  AS cry_legacy,
  from POKEDB.GIT.POKE_DETAIL poke_det

-- Form Flattened
 Select (SELECT
  id,name,
  f.value:name::STRING   AS form_name,
  f.value:url::STRING   AS form_url
  from POKEDB.GIT.POKE_DETAIL poke_det
  ,
        LATERAL FLATTEN( input => PARSE_JSON(REPLACE(REPLACE(REPLACE(REPLACE(poke_det.forms, 'True', 'true'), 'False', 'false'), 'None', 'null'), '''', '"')) ) f

-- Game Index Flattened
 SELECT
  id,name,
  gi.value:game_index::STRING   AS game_index,
  gi.value:version.name::STRING   AS game_name,
  from POKEDB.GIT.POKE_DETAIL poke_det
  ,
        LATERAL FLATTEN( input => PARSE_JSON(REPLACE(REPLACE(REPLACE(REPLACE(poke_det.GAME_INDICES, 'True', 'true'), 'False', 'false'), 'None', 'null'), '''', '"')) ) gi

-- Held Items Flattened
 SELECT
  id,name,
  h.value:item.name::STRING   AS held_item_name,
  h.value:item.url::STRING   AS held_item_name_url,
  v.value:rarity::INT        AS rarity,
  v.value:version.name::STRING AS version_name,
  v.value:version.url::STRING  AS version_url
  from POKEDB.GIT.POKE_DETAIL poke_det
  ,
        LATERAL FLATTEN( input => PARSE_JSON(REPLACE(REPLACE(REPLACE(REPLACE(poke_det.HELD_ITEMS, 'True', 'true'), 'False', 'false'), 'None', 'null'), '''', '"')) ) h,
        LATERAL FLATTEN( input => PARSE_JSON(h.value:version_details) ) v

-- Moves Flattened
 SELECT
  id,name,
  m.value:move.name::STRING   AS move_name,
  m.value:move.url::STRING   AS move_name_url,
  v.value:level_learned_at::STRING        AS level_learned_at,
  v.value:move_learn_method.name::STRING        AS move_learn_method_name,
  v.value:move_learn_method.url::STRING       AS move_learn_method_url,
  v.value:order::INT        AS move_order,
  v.value:version_group.name::STRING        AS move_learn_method_name,
  v.value:version_group.url::STRING        AS move_learn_method_url
  from POKEDB.GIT.POKE_DETAIL poke_det
  ,
        LATERAL FLATTEN( input => PARSE_JSON(REPLACE(REPLACE(REPLACE(REPLACE(poke_det.MOVES, 'True', 'true'), 'False', 'false'), 'None', 'null'), '''', '"')) ) m,
        LATERAL FLATTEN( input => PARSE_JSON(m.value:version_group_details) ) v

-- Past Abilities Flattened
 SELECT
  id,name,
  a1.value:ability::STRING   AS past_abilities_name,
  a1.value:is_hidden::BOOLEAN   AS is_hidden,
  a1.value:slot::INT   AS past_abilities_slot,
  pa.value:generation.name::STRING   AS past_abilities_gen_name,
  pa.value:generation.url::STRING   AS past_abilities_gen_url,
  from POKEDB.GIT.POKE_DETAIL poke_det
  ,
        LATERAL FLATTEN( input => PARSE_JSON(REPLACE(REPLACE(REPLACE(REPLACE(poke_det.PAST_ABILITIES, 'True', 'true'), 'False', 'false'), 'None', 'null'), '''', '"')) ) pa,
        LATERAL FLATTEN( input => parse_json(pa.value:abilities) ) a1

-- Past Stat Flattened
 SELECT
  id,name,
  ps.value:generation.name::STRING   AS past_stat_gen,
  ps.value:generation.url::STRING   AS past_stat_gen_url,
  a1.value:base_stat::STRING   AS past_stat_base_stat,
  a1.value:effort::STRING   AS past_stat_effort,
  a1.value:stat.name::STRING   AS past_stat_name,
  a1.value:stat.url::STRING   AS past_stat_url
  from POKEDB.GIT.POKE_DETAIL poke_det
  ,
        LATERAL FLATTEN( input => PARSE_JSON(REPLACE(REPLACE(REPLACE(REPLACE(poke_det.PAST_STATS, 'True', 'true'), 'False', 'false'), 'None', 'null'), '''', '"')) ) ps,
        LATERAL FLATTEN( input => parse_json(ps.value:stats) ) a1

-- Past Types Flattened
 SELECT
  id,name,
  pt.value:generation.name::STRING   AS past_type_gen,
  pt.value:generation.url::STRING   AS past_type_gen_url,
  a1.value:slot::STRING   AS slot,
  a1.value:type.name::STRING   AS past_type_name,
  a1.value:type.url::STRING   AS past_type_url
  from POKEDB.GIT.POKE_DETAIL poke_det
  ,
        LATERAL FLATTEN( input => PARSE_JSON(REPLACE(REPLACE(REPLACE(REPLACE(poke_det.PAST_TYPES, 'True', 'true'), 'False', 'false'), 'None', 'null'), '''', '"')) ) pt,
        LATERAL FLATTEN( input => parse_json(pt.value:types) ) a1

-- Species Flattened
 SELECT
  id,name,
  PARSE_JSON(REPLACE(REPLACE(REPLACE(REPLACE(poke_det.SPECIES, 'True', 'true'), 'False', 'false'), 'None', 'null'), '''', '"')):name::STRING   AS species_name,
  PARSE_JSON(REPLACE(REPLACE(REPLACE(REPLACE(poke_det.SPECIES, 'True', 'true'), 'False', 'false'), 'None', 'null'), '''', '"')):url::STRING   AS species_url
  from POKEDB.GIT.POKE_DETAIL poke_det

-- Spirtes Flattened
 SELECT
  id,name,
  PARSE_JSON(REPLACE(REPLACE(REPLACE(REPLACE(poke_det.SPRITES, 'True', 'true'), 'False', 'false'), 'None', 'null'), '''', '"')):back_default::STRING   AS back_default,
  PARSE_JSON(REPLACE(REPLACE(REPLACE(REPLACE(poke_det.SPRITES, 'True', 'true'), 'False', 'false'), 'None', 'null'), '''', '"')):back_shiny::STRING   AS back_shiny,
  PARSE_JSON(REPLACE(REPLACE(REPLACE(REPLACE(poke_det.SPRITES, 'True', 'true'), 'False', 'false'), 'None', 'null'), '''', '"')):back_female::STRING   AS back_female,
  PARSE_JSON(REPLACE(REPLACE(REPLACE(REPLACE(poke_det.SPRITES, 'True', 'true'), 'False', 'false'), 'None', 'null'), '''', '"')):back_shiny_female::STRING   AS back_shiny_female,
  PARSE_JSON(REPLACE(REPLACE(REPLACE(REPLACE(poke_det.SPRITES, 'True', 'true'), 'False', 'false'), 'None', 'null'), '''', '"')):front_default::STRING   AS front_default,
  PARSE_JSON(REPLACE(REPLACE(REPLACE(REPLACE(poke_det.SPRITES, 'True', 'true'), 'False', 'false'), 'None', 'null'), '''', '"')):front_shiny::STRING   AS front_shiny,
  PARSE_JSON(REPLACE(REPLACE(REPLACE(REPLACE(poke_det.SPRITES, 'True', 'true'), 'False', 'false'), 'None', 'null'), '''', '"')):front_female::STRING   AS front_female,
  PARSE_JSON(REPLACE(REPLACE(REPLACE(REPLACE(poke_det.SPRITES, 'True', 'true'), 'False', 'false'), 'None', 'null'), '''', '"')):front_shiny_female::STRING   AS front_shiny_female
  from POKEDB.GIT.POKE_DETAIL poke_det

-- Stats Flattened
 SELECT
  id,name,
  st.value:base_stat::STRING   AS base_stat,
  st.value:effort::STRING   AS effort,
  st.value:stat.name::STRING   AS stat_name,
  st.value:stat.url::STRING   AS stat_url
  from POKEDB.GIT.POKE_DETAIL poke_det
  ,
        LATERAL FLATTEN( input => PARSE_JSON(REPLACE(REPLACE(REPLACE(REPLACE(poke_det.STATS, 'True', 'true'), 'False', 'false'), 'None', 'null'), '''', '"')) ) st

-- type Flattened
 SELECT
  id,name,
  ty.value:type.name::STRING   AS type_name,
  ty.value:type.url::STRING   AS type_url,
  ty.value:slot::STRING   AS slot,
  from POKEDB.GIT.POKE_DETAIL poke_det
  ,
        LATERAL FLATTEN( input => PARSE_JSON(REPLACE(REPLACE(REPLACE(REPLACE(poke_det.TYPES, 'True', 'true'), 'False', 'false'), 'None', 'null'), '''', '"')) ) ty

-- LANGUAGE
-- Names Flattened
SELECT
  id,name as language_base_name,
  l.value:language.name::STRING   AS language_derive_name,
  l.value:language.url::STRING   AS language_derive_url,
  l.value:name::STRING   AS language_name,
  -- a1.value:slot::STRING   AS slot,
  -- a1.value:type.name::STRING   AS past_type_name,
  -- a1.value:type.url::STRING   AS past_type_url
  from POKEDB.GIT.POKE_LANGUAGE poke_lang
  ,
        LATERAL FLATTEN( input => PARSE_JSON(REPLACE(REPLACE(REPLACE(REPLACE(poke_lang.NAMES, 'True', 'true'), 'False', 'false'), 'None', 'null'), '''', '"')) ) l

-- ABILITY
-- Effect changes Flattened
 SELECT
  id,name,
  a1.value:effect::STRING   AS effect_desc,
  a1.value:language.name::STRING   AS effect_language_name,
  a1.value:language.url::STRING   AS effect_language_url,
  ec.value:version_group.name::STRING   AS effect_version_group_name
  from POKEDB.GIT.POKE_ABILITY poke_abt
  ,
        LATERAL FLATTEN( input => PARSE_JSON(
          REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
            REPLACE(REPLACE(REPLACE(poke_abt.EFFECT_CHANGES, 'True', 'true'), 'False', 'false'), 'None', 'null'),
            ''': ''', '": "'),
            ''': "', '": "'),
            '": ''', '": "'),
            '{''', '{"'),
            '''}', '"}'),
            '[''', '["'),
            ''']', '"]'),
            ''', ''', '", "'),
            ''', "', '", "'),
            '", ''', '", "'),
            ''', {', '", {'),
            '}, ''', '}, "'),
            '], ''', '], "'),
            ''': [', '": ['),
            ''': {', '": {')
        ) ) ec,
        LATERAL FLATTEN( input => ec.value:effect_entries ) a1

-- Effect entries Flattened
 SELECT
  id,name,
  ee.value:effect::STRING   AS effect_desc,
  ee.value:language.name::STRING   AS effect_language_name,
  ee.value:language.url::STRING   AS effect_language_url,
  ee.value:short_effect::STRING   AS short_effect_name
  from POKEDB.GIT.POKE_ABILITY poke_abt
  ,
        LATERAL FLATTEN( input => PARSE_JSON(
          
            REPLACE(REPLACE(REPLACE(poke_abt.EFFECT_ENTRIES, 'True', 'true'), 'False', 'false'), 'None', 'null')
        ) ) ee

-- Flavor text entries flattened
SELECT 
id,name,
  fte.value:flavor_text::STRING as flavor_text,
  fte.value:language.name::STRING as language_name,
  fte.value:version_group.name::STRING as version_group_name
FROM POKEDB.GIT.POKE_ABILITY poke_abt
,
    LATERAL FLATTEN( input => PARSE_JSON(
            REPLACE(REPLACE(REPLACE(poke_abt.FLAVOR_TEXT_ENTRIES, 'True', 'true'), 'False', 'false'), 'None', 'null')) ) fte

-- Genereation flattened
 SELECT
  id,name,
  PARSE_JSON(REPLACE(REPLACE(REPLACE(REPLACE(poke_abt.GENERATION, 'True', 'true'), 'False', 'false'), 'None', 'null'), '''', '"')):name::STRING   AS generation_name,
  PARSE_JSON(REPLACE(REPLACE(REPLACE(REPLACE(poke_abt.GENERATION, 'True', 'true'), 'False', 'false'), 'None', 'null'), '''', '"')):url::STRING   AS generation_url
  from POKEDB.GIT.POKE_ABILITY poke_abt

-- Names flattened
 SELECT
  id,name,
  en.value:name::STRING as ability_name,
  en.value:language.name::STRING as language_name,
  en.value:language.url::STRING as language_url
  from POKEDB.GIT.POKE_ABILITY poke_abt
  ,
        LATERAL FLATTEN( input => PARSE_JSON(
          REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
            REPLACE(REPLACE(REPLACE(poke_abt.NAMES, 'True', 'true'), 'False', 'false'), 'None', 'null'),
            ''': ''', '": "'),
            ''': "', '": "'),
            '": ''', '": "'),
            '{''', '{"'),
            '''}', '"}'),
            '[''', '["'),
            ''']', '"]'),
            ''', ''', '", "'),
            ''', "', '", "'),
            '", ''', '", "'),
            ''', {', '", {'),
            '}, ''', '}, "'),
            '], ''', '], "'),
            ''': [', '": ['),
            ''': {', '": {')
        ) ) en

-- Pokemon flattened
  SELECT
  id,name,
  epk.value:is_hidden::BOOLEAN as is_hidden,
  epk.value:pokemon.name::STRING as pokemon_name,
  epk.value:pokemon.url::STRING as pokemon_url,
  epk.value:slot::INTEGER as slot
  from POKEDB.GIT.POKE_ABILITY poke_abt
  ,
        LATERAL FLATTEN( input => PARSE_JSON(
          
            REPLACE(REPLACE(REPLACE(poke_abt.POKEMON, 'True', 'true'), 'False', 'false'), 'None', 'null')
        ) ) epk

--BERRY 1

