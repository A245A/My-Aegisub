function char_index(inputstr)
   local lenInByte = #inputstr
   local index = {}
   local index_c = 1
   local i = 1
   while (i <= lenInByte) do
        local curByte = string.byte(inputstr, i)
        local byteCount = 1;
        if curByte>0 and curByte<=127 then
            byteCount = 1
        elseif curByte>=192 and curByte<223 then
            byteCount = 2
        elseif curByte>=224 and curByte<239 then
            byteCount = 3
        elseif curByte>=240 and curByte<=247 then
            byteCount = 4
        end
        index[index_c] = {start_idx = i, end_idx = i+byteCount-1}
        index_c = index_c + 1
        i = i + byteCount
    end
    return index
end

function LineIndex(linetext)
    idx_line = {}
    local index = char_index(linetext)
    for i = 1, #index, 1 do
        idx_line[i] = string.sub(linetext, index[i].start_idx, index[i].end_idx)
    end
end

function SylIndex(syltext, si)
    local idx_syl = {}
    local index = char_index(syltext)
    for i = 1, #index, 1 do
        idx_syl[i] = string.sub(syltext, index[i].start_idx, index[i].end_idx)
    end
    idx_syl[1] = idx_line[si]
    return idx_syl[1]
end

function TEMP(text)
    local index = char_index(text)
    idx = string.sub(text, index[1].start_idx, index[1].end_idx)
    return idx
end

line.kara[$si].text_stripped

function smoke(swidth, height, scenter, bottom, sdur, j)
    local part_w = swidth / 8 local part_h = height / 8
    local random_x_l = 0 local random_y_l = 0
    local symbol = {1, -1}
    fscn = 0
    if(j <= 5) then
        random_x_l = scenter+math.random(0, part_w)*symbol[math.random(1,2)]
        random_y_l = bottom-math.random(0, part_h)
        fscn = 300
    elseif(j <= 30) then
        random_x_l = scenter+math.random(0, part_w*1.5)*symbol[math.random(1,2)]
        random_y_l = bottom-math.random(part_h, part_h*3)
        fscn = 400
    elseif(j <= 60) then
        random_x_l = scenter+math.random(0, part_w*2.5)*symbol[math.random(1,2)]
        random_y_l = bottom-math.random(part_h*3, part_h*6)
        fscn = 500
    end
    local fire_move = string.format('{\\move(%d,%d,%d,%d)}', scenter, bottom, random_x_l, random_y_l)
    local fire_alpha = string.format('{\\alphaff\\t(0,%d,\\alphah0)\\t(%d,%d,\\alphaff)}', 50, 150, 250)
    local combin = fire_alpha..fire_move
    return combin
end

