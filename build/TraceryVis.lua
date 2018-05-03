tracery.Grammar.prototype.calculateDepth = (function (originWord)
  local keys = Object.keys(self.symbols)
  local symbols = self.symbols
  $.each(keys, (function (index, key)
    local symbol = symbols[key]
    symbol.stats = {
      visits = {},
      leafPct = 0
    }
    local rules = symbol.getActiveRules()
  end))
end)
tracery.Grammar.prototype.distributionVisualization = (function (holder, settings)
  holder.html("")
  local keys = Object.keys(self.symbols)
  local unused = {}
  $.each(keys, (function (index, key)
    local s = app.grammar.symbols[key]
    if s.uses.length > 0 then
      local totalDepth = 0
      local i = 0
      while i < s.uses.length do --[[pinecone converted for statement]]
        totalDepth += s.uses[i].node.depth
        i = i + 1
      end
      totalDepth /= s.uses.length
      local div = $("<div/>", {
        class = "tracery-usage-graph"
      }).appendTo(holder)
      local label = $("<div/>", {
        class = "label",
        text = (((key + ": ") + s.uses.length) + " d:") + totalDepth.toFixed(1)
      }).appendTo(div)
      local graph = $("<div/>", {
        class = "bars"
      }).appendTo(div)
      if s.baseRules.defaultRules then
        local count = s.baseRules.defaultRules.length
        local max = 0
        $.each(s.baseRules.defaultRules, (function (index, rule)
          if s.baseRules.defaultUses[index] then
            max = Math.max(s.baseRules.defaultUses[index], max)
          end
        end))
        $.each(s.baseRules.defaultRules, (function (index, rule)
          local useCount = 0
          local h = 1
          if s.baseRules.defaultUses[index] then
            h = (s.baseRules.defaultUses[index] / max) * 100
            useCount = s.baseRules.defaultUses[index]
          end
          local bar = $("<div/>", {
            class = "bar"
          }).appendTo(graph).css({
            width = h + "%",
            top = ((index / count) * 100) + "%",
            height = ((1 / count) * 100) + "%"
          })
          local label = $("<div/>", {
            class = "bar-label",
            text = (useCount + " ") + rule
          }).appendTo(bar)
        end))
      end
    else
      unused.push(s)
    end
  end))
end)
tracery.Grammar.prototype.cascadeVisualization = (function (holder, settings)
  local symbols = $("<div/>", {
    class = "grammar-viz"
  }).appendTo(holder)
  for local key in pairs(self.symbols) do
    local symbol = self.symbols[key]
    local symbolDiv = $("<div/>", {
      class = "symbol"
    }).appendTo(symbols)
    local header = $("<div/>", {
      class = "header",
      text = key
    }).appendTo(symbolDiv)
    local baseRuleHolder = $("<div/>", {
      class = "rules"
    }).appendTo(symbolDiv)
    local rules = symbol.baseRules
    if not rules then
      console.log(symbol)
    end
    local i = 0
    while i < rules.length do --[[pinecone converted for statement]]
      ruleToDiv(rules[i]).appendTo(baseRuleHolder)
      i = i + 1
    end
  end
end)
function ruleToDiv(rule)
  local sections = tracery.parse(rule)
  local div = $("<div/>", {
    class = "rule"
  })
  local i = 0
  while i < sections.length do --[[pinecone converted for statement]]
    local sectionDiv = $("<div/>", {
      class = "section section" + sections[i].type,
      text = sections[i].raw
    }).appendTo(div)
    i = i + 1
  end
  return div
end
--[[Failed to convert 4371 to 4372: unknown node EmptyStatement]]
tracery.Grammar.prototype.referenceVisualization = (function (holder, settings) end)
tracery.TraceryNode.prototype.visualizeExpansion = (function (holder, settings)
  local div = $("<div/>", {
    class = "tracery-node tracery-node" + self.type
  }).appendTo(holder)
  if self == settings.active then
    div.addClass("active")
  end
  if self.grammar.symbols[self.symbol] then
    if self.grammar.symbols[self.symbol].isDynamic then
      div.addClass("dynamic")
    end
  else
    div.addClass("missing")
  end
  local header = $("<div/>", {
    class = "header"
  }).appendTo(div)
  if self.type == 1 then
    header.text(self.symbol)
  else
    header.text(self.finishedText)
  end
  if self.preActions then
    $.each(self.preActions, (function (index, action)
      local command = $("<div/>", {
        class = "action-command",
        text = (action.target + ":") + action.rule
      }).appendTo(div)
      local text = $("<div/>", {
        class = "action-text",
        text = action.ruleText
      }).appendTo(div)
    end))
  end
  if self.children then
    local childHolder = $("<div/>", {
      class = "children"
    }).appendTo(div)
    local i = 0
    while i < self.children.length do --[[pinecone converted for statement]]
      self.children[i].visualizeExpansion(childHolder, settings)
      i = i + 1
    end
  end
end)
tracery.rawGrammarToPrettyHTML = (function (raw)
  local s = ""
  local keyOutputs = {}
  for local key in pairs(raw) do
    if raw.hasOwnProperty(key) then
      local rules = JSON.stringify(raw[key])
      rules = escapeHTML(rules)
      keyOutputs.push((("<b>\\"" + key) + "\\":</b>") + rules)
    end
  end
  return keyOutputs.join(",<br>")
end)
