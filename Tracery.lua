local tracery = (function ()
  local rng = Math.random
  local setRng = (function --[[setRng]](newRng)
    rng = newRng
  end)
  local TraceryNode = (function (parent, childIndex, settings)
    self.errors = {}
    if settings.raw == nil then
      self.errors.push("Empty input for node")
      settings.raw = ""
    end
    if parent instanceof tracery.Grammar then
      self.grammar = parent
      self.parent = nil
      self.depth = 0
      self.childIndex = 0
    else
      self.grammar = parent.grammar
    self.parent = parent
    self.depth = parent.depth + 1
    self.childIndex = childIndex
    end
    self.raw = settings.raw
    self.type = settings.type
    self.isExpanded = false
    if not self.grammar then
      console.warn("No grammar specified for this node", self)
    end
  end)
  TraceryNode.prototype.toString = (function ()
    return ((((("Node('" + self.raw) + "' ") + self.type) + " d:") + self.depth) + ")"
  end)
  TraceryNode.prototype.expandChildren = (function (childRule, preventRecursion)
    self.children = {}
    self.finishedText = ""
    self.childRule = childRule
    if self.childRule ~= nil then
      local sections = tracery.parse(childRule)
      if sections.errors.length > 0 then
        self.errors = self.errors.concat(sections.errors)
      end
      local i = 0
      while i < sections.length do --[[pinecone converted for statement]]
        self.children[i] = --[[Failed to convert 1724 to 1761: pinecone can't convert new obj(); statements]]
        if not preventRecursion then
          self.children[i].expand(preventRecursion)
        end
        self.finishedText += self.children[i].finishedText
        i = i + 1
      end
    else
      self.errors.push("No child rule provided, can't expand children")
    console.warn("No child rule provided, can't expand children")
    end
  end)
  TraceryNode.prototype.expand = (function (preventRecursion)
    if not self.isExpanded then
      self.isExpanded = true
      self.expansionErrors = {}
      --[[Failed to convert 2573 to 5504: unknown node SwitchStatement]]
    else
      
    end
  end)
  TraceryNode.prototype.clearEscapeChars = (function ()
    self.finishedText = self.finishedText.replace(--[[Failed to convert 5678 to 5685: Can't convert regex into Lua yet.]], "DOUBLEBACKSLASH").replace(--[[Failed to convert 5714 to 5719: Can't convert regex into Lua yet.]], "").replace(--[[Failed to convert 5733 to 5751: Can't convert regex into Lua yet.]], "\\")
  end)
  function NodeAction(node, raw)
    self.node = node
    local sections = raw.split(":")
    self.target = sections[0]
    if sections.length == 1 then
      self.type = 2
    else
      self.rule = sections[1]
    if self.rule == "POP" then
      self.type = 1
    else
      self.type = 0
    end
    end
  end
  NodeAction.prototype.createUndo = (function ()
    if self.type == 0 then
      return --[[Failed to convert 6522 to 6569: pinecone can't convert new obj(); statements]]
    end
    return nil
  end)
  NodeAction.prototype.activate = (function ()
    local grammar = self.node.grammar
    --[[Failed to convert 6744 to 7380: unknown node SwitchStatement]]
  end)
  NodeAction.prototype.toText = (function ()
    --[[Failed to convert 7433 to 7633: unknown node SwitchStatement]]
  end)
  function RuleSet(grammar, raw)
    self.raw = raw
    self.grammar = grammar
    self.falloff = 1
    if Array.isArray(raw) then
      self.defaultRules = raw
    elseif (type(raw) == "string") or (raw instanceof String) then
      self.defaultRules = {raw}
    elseif raw == "object" then
      
    end
  end
  --[[Failed to convert 8074 to 8075: unknown node EmptyStatement]]
  RuleSet.prototype.selectRule = (function (errors)
    if self.conditionalRule then
      local value = self.grammar.expand(self.conditionalRule, true)
      if self.conditionalValues[value] then
        local v = self.conditionalValues[value].selectRule(errors)
        if (v ~= nil) and (v ~= nil) then
          return v
        end
      end
    end
    if self.ranking then
      local i = 0
      while i < self.ranking.length do --[[pinecone converted for statement]]
        local v = self.ranking.selectRule()
        if (v ~= nil) and (v ~= nil) then
          return v
        end
        i = i + 1
      end
    end
    if self.defaultRules ~= nil then
      local index = 0
      local distribution = self.distribution
      if not distribution then
        distribution = self.grammar.distribution
      end
      --[[Failed to convert 9055 to 9708: unknown node SwitchStatement]]
      if not self.defaultUses then
        self.defaultUses = {}
      end
      self.defaultUses[index] = (function()self.defaultUses[index]=self.defaultUses[index]+1;return self.defaultUses[index] end)(--[[++self.defaultUses[index]]]) or 1
      return self.defaultRules[index]
    end
    errors.push("No default rules defined for " + self)
    return nil
  end)
  RuleSet.prototype.clearState = (function ()
    if self.defaultUses then
      self.defaultUses = {}
    end
  end)
  function fyshuffle(array, falloff)
    local currentIndex, temporaryValue, randomIndex = array.length, nil, nil
    while 0 ~= currentIndex do
      randomIndex = Math.floor(rng() * currentIndex)
      currentIndex -= 1
      temporaryValue = array[currentIndex]
      array[currentIndex] = array[randomIndex]
      array[randomIndex] = temporaryValue
    end
    return array
  end
  local Symbol = (function (grammar, key, rawRules)
    self.key = key
    self.grammar = grammar
    self.rawRules = rawRules
    self.baseRules = --[[Failed to convert 10786 to 10821: pinecone can't convert new obj(); statements]]
    self.clearState()
  end)
  Symbol.prototype.clearState = (function ()
    self.stack = {self.baseRules}
    self.uses = {}
    self.baseRules.clearState()
  end)
  Symbol.prototype.pushRules = (function (rawRules)
    local rules = --[[Failed to convert 11098 to 11133: pinecone can't convert new obj(); statements]]
    self.stack.push(rules)
  end)
  Symbol.prototype.popRules = (function ()
    self.stack.pop()
  end)
  Symbol.prototype.selectRule = (function (node, errors)
    self.uses.push({
      node = node
    })
    if self.stack.length == 0 then
      errors.push(("The rule stack for '" + self.key) + "' is empty, too many pops?")
      return ("((" + self.key) + "))"
    end
    return self.stack[self.stack.length - 1].selectRule()
  end)
  Symbol.prototype.getActiveRules = (function ()
    if self.stack.length == 0 then
      return nil
    end
    return self.stack[self.stack.length - 1].selectRule()
  end)
  Symbol.prototype.rulesToJSON = (function ()
    return JSON.stringify(self.rawRules)
  end)
  local Grammar = (function (raw, settings)
    self.modifiers = {}
    self.loadFromRawObj(raw)
  end)
  Grammar.prototype.clearState = (function ()
    local keys = Object.keys(self.symbols)
    local i = 0
    while i < keys.length do --[[pinecone converted for statement]]
      self.symbols[keys[i]].clearState()
      i = i + 1
    end
  end)
  Grammar.prototype.addModifiers = (function (mods)
    for local key in pairs(mods) do
      if mods.hasOwnProperty(key) then
        self.modifiers[key] = mods[key]
      end
    end
    --[[Failed to convert 12263 to 12264: unknown node EmptyStatement]]
  end)
  Grammar.prototype.loadFromRawObj = (function (raw)
    self.raw = raw
    self.symbols = {}
    self.subgrammars = {}
    if self.raw then
      for local key in pairs(self.raw) do
        if self.raw.hasOwnProperty(key) then
          self.symbols[key] = --[[Failed to convert 12538 to 12574: pinecone can't convert new obj(); statements]]
        end
      end
    end
  end)
  Grammar.prototype.createRoot = (function (rule)
    local root = --[[Failed to convert 12690 to 12750: pinecone can't convert new obj(); statements]]
    return root
  end)
  Grammar.prototype.expand = (function (rule, allowEscapeChars)
    local root = self.createRoot(rule)
    root.expand()
    if not allowEscapeChars then
      root.clearEscapeChars()
    end
    return root
  end)
  Grammar.prototype.flatten = (function (rule, allowEscapeChars)
    local root = self.expand(rule, allowEscapeChars)
    return root.finishedText
  end)
  Grammar.prototype.toJSON = (function ()
    local keys = Object.keys(self.symbols)
    local symbolJSON = {}
    local i = 0
    while i < keys.length do --[[pinecone converted for statement]]
      local key = keys[i]
      symbolJSON.push(((" \\"" + key) + "\\" : ") + self.symbols[key].rulesToJSON())
      i = i + 1
    end
    return ("{\\n" + symbolJSON.join(",\\n")) + "\\n}"
  end)
  Grammar.prototype.pushRules = (function (key, rawRules, sourceAction)
    if self.symbols[key] == nil then
      self.symbols[key] = --[[Failed to convert 13573 to 13604: pinecone can't convert new obj(); statements]]
      if sourceAction then
        self.symbols[key].isDynamic = true
      end
    else
      self.symbols[key].pushRules(rawRules)
    end
  end)
  Grammar.prototype.popRules = (function (key)
    if not self.symbols[key] then
      self.errors.push("Can't pop: no symbol for key " + key)
    end
    self.symbols[key].popRules()
  end)
  Grammar.prototype.selectRule = (function (key, node, errors)
    if self.symbols[key] then
      local rule = self.symbols[key].selectRule(node, errors)
      return rule
    end
    local i = 0
    while i < self.subgrammars.length do --[[pinecone converted for statement]]
      if self.subgrammars[i].symbols[key] then
        return self.subgrammars[i].symbols[key].selectRule()
      end
      i = i + 1
    end
    errors.push(("No symbol for '" + key) + "'")
    return ("((" + key) + "))"
  end)
  tracery = {
    createGrammar = (function (raw)
    return --[[Failed to convert 14470 to 14486: pinecone can't convert new obj(); statements]]
  end),
    parseTag = (function (tagContents)
    local parsed = {
      symbol = nil,
      preactions = {},
      postactions = {},
      modifiers = {}
    }
    local sections = tracery.parse(tagContents)
    local symbolSection = nil
    local i = 0
    while i < sections.length do --[[pinecone converted for statement]]
      if sections[i].type == 0 then
        if symbolSection == nil then
          symbolSection = sections[i].raw
        else
          error("BAD JS".."multiple main sections in " + tagContents)
        end
      else
        parsed.preactions.push(sections[i])
      end
      i = i + 1
    end
    if symbolSection == nil then
      
    else
      local components = symbolSection.split(".")
    parsed.symbol = components[0]
    parsed.modifiers = components.slice(1)
    end
    return parsed
  end),
    parse = (function (rule)
    local depth = 0
    local inTag = false
    local sections = {}
    local escaped = false
    local errors = {}
    local start = 0
    local escapedSubstring = ""
    local lastEscapedChar = nil
    if rule == nil then
      local sections = {}
      sections.errors = errors
      return sections
    end
    function createSection(start, end, type)
      if (end - start) < 1 then
        if type == 1 then
          errors.push(start + ": empty tag")
        end
        if type == 2 then
          errors.push(start + ": empty action")
        end
      end
      local rawSubstring
      if lastEscapedChar ~= nil then
        rawSubstring = (escapedSubstring + "\\") + rule.substring((lastEscapedChar + 1), end)
      else
        rawSubstring = rule.substring(start, end)
      end
      sections.push({
        type = type,
        raw = rawSubstring
      })
      lastEscapedChar = nil
      escapedSubstring = ""
    end
    --[[Failed to convert 16207 to 16208: unknown node EmptyStatement]]
    local i = 0
    while i < rule.length do --[[pinecone converted for statement]]
      if not escaped then
        local c = rule.charAt(i)
        --[[Failed to convert 16309 to 17238: unknown node SwitchStatement]]
      else
        escaped = false
      end
      i = i + 1
    end
    if start < rule.length then
      createSection(start, rule.length, 0)
    end
    if inTag then
      errors.push("Unclosed tag")
    end
    if depth > 0 then
      errors.push("Too many [")
    end
    if depth < 0 then
      errors.push("Too many ]")
    end
    sections = sections.filter((function (section)
      if (section.type == 0) and (section.raw.length == 0) then
        return false
      end
      return true
    end))
    sections.errors = errors
    return sections
  end)
  }
  tracery.TraceryNode = TraceryNode
  tracery.Grammar = Grammar
  tracery.Symbol = Symbol
  tracery.RuleSet = RuleSet
  tracery.setRng = setRng
  return tracery
end)()
