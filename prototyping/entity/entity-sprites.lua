
if not LSlib.entity then require "entity" else

  function LSlib.entity.addTintToAnimation(animation, tintToAdd)
    -- https://wiki.factorio.com/Types/Animation
    return LSlib.entity.addTintToSprite(animation, tintToAdd)
  end



  function LSlib.entity.addTintToSprite(sprite, tintToAdd)
    -- https://wiki.factorio.com/Types/Sprite

    if sprite.layers then
      -- https://wiki.factorio.com/Types/Sprite#layers
      for layerIndex,layerSprite in pairs(sprite.layers) do
        sprite.layers[layerIndex] = LSlib.entity.addTintToSprite(layerSprite, tintToAdd)
      end

    else
      if not sprite.draw_as_shadow then
        -- it has no effect, adding a tint to a shadow
        sprite.tint = util.table.deepcopy(tintToAdd)
      end
      if sprite.hr_version and (not sprite.hr_version.draw_as_shadow) then
        sprite.hr_version.tint = util.table.deepcopy(tintToAdd)
      end
    end

    return sprite
  end



  function LSlib.entity.addTintToSpriteVariation(spriteVariaton, tintToAdd)
    -- https://wiki.factorio.com/Types/SpriteVariations

    if spriteVariaton.layers or spriteVariaton.filename then
      spriteVariaton = LSlib.entity.addTintToSprite(spriteVariaton, tintToAdd)

    else
      for variationIndex, variation in pairs(spriteVariaton) do
        spriteVariaton[variationIndex] = LSlib.entity.addTintToSprite(variation, tintToAdd)
      end
    end

    return spriteVariaton
  end



  function LSlib.entity.addTintToSprite4Way(sprite4Way, tintToAdd)
    -- https://wiki.factorio.com/Types/Sprite4Way

    if sprite4Way.sheet then
      -- https://wiki.factorio.com/Types/Sprite4Way#sheet
      sprite4Way.sheet = LSlib.entity.addTintToSprite(sprite4Way.sheet, tintToAdd)

    elseif sprite4Way.sheets then
      -- https://wiki.factorio.com/Types/Sprite4Way#sheets
      for sheetIndex,sheet in pairs(sprite4Way.sheets) do
        sprite4Way.sheets[sheetIndex] = LSlib.entity.addTintToSprite(sheet, tintToAdd)
      end

    elseif not sprite4Way.north then
      -- https://wiki.factorio.com/Types/Sprite4Way#north
      sprite4Way = LSlib.entity.addTintToSprite(sprite4Way, tintToAdd)

    else
      for direction,sprite in pairs(sprite4Way) do
        sprite4Way[direction] = LSlib.entity.addTintToSprite(sprite, tintToAdd)
      end
    end

    return sprite4Way
  end

end