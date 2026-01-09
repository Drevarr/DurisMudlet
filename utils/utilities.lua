function comma_value(amount)
    -- Convert the number to a string and ensure it's an integer part for comma separation
    local formatted = string.format('%.0f', amount)
    local k
    while true do
        -- Substitute the pattern of an optional minus sign, followed by 
        -- one or more digits, and then exactly three digits. Inserts a comma.
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        -- If no substitution occurred (k==0), break the loop
        if (k == 0) then
            break
        end
    end
    return formatted
end

function strip_mud_colors(text)
    -- Remove combined bg+fg codes (e.g. &=ab)
    text = text:gsub("&=%a%a", "")

    -- Remove foreground / background codes (e.g. &+r or &-B)
    text = text:gsub("&[+-]%a", "")

    -- Remove reset codes
    text = text:gsub("&[nN]", "")

    return text
end
