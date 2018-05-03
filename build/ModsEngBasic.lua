function isVowel(c)
  local c2 = c.toLowerCase()
  return ((((c2 == "a") or (c2 == "e")) or (c2 == "i")) or (c2 == "o")) or (c2 == "u")
end
--[[Failed to convert 161 to 162: unknown node EmptyStatement]]
function isAlphaNum(c)
  return (((c >= "a") and (c <= "z")) or ((c >= "A") and (c <= "Z"))) or ((c >= "0") and (c <= "9"))
end
--[[Failed to convert 274 to 275: unknown node EmptyStatement]]
function escapeRegExp(str)
  return str.replace(--[[Failed to convert 325 to 354: Can't convert regex into Lua yet.]], "\\$1")
end
local baseEngModifiers = {
  replace = (function (s, params)
  return s.replace(--[[Failed to convert 545 to 585: pinecone can't convert new obj(); statements]], params[1])
end),
  capitalizeAll = (function (s)
  local s2 = ""
  local capNext = true
  local i = 0
  while i < s.length do --[[pinecone converted for statement]]
    if not isAlphaNum(s.charAt(i)) then
      capNext = true
      s2 += s.charAt(i)
    else
      if not capNext then
      s2 += s.charAt(i)
    else
      s2 += s.charAt(i).toUpperCase()
    capNext = false
    end
    end
    i = i + 1
  end
  return s2
end),
  capitalize = (function (s)
  return s.charAt(0).toUpperCase() + s.substring(1)
end),
  a = (function (s)
  if s.length > 0 then
    if s.charAt(0).toLowerCase() == "u" then
      if s.length > 2 then
        if s.charAt(2).toLowerCase() == "i" then
          return "a " + s
        end
      end
    end
    if isVowel(s.charAt(0)) then
      return "an " + s
    end
  end
  return "a " + s
end),
  firstS = (function (s)
  console.log(s)
  local s2 = s.split(" ")
  local finished = (baseEngModifiers.s(s2[0]) + " ") + s2.slice(1).join(" ")
  console.log(finished)
  return finished
end),
  s = (function (s)
  --[[Failed to convert 1527 to 1859: unknown node SwitchStatement]]
end),
  ed = (function (s)
  --[[Failed to convert 1886 to 2260: unknown node SwitchStatement]]
end)
}
