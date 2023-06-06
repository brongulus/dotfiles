-- Credits: 
-- yazgoo/elinks-nolinks 
-- yazgoo/elinks-basis
----------------------------------------------------------------------
-- hooks
----------------------------------------------------------------------

pre_format_html_hooks = {n=0}
pre_format_html_hooks_names = {n=0}
function pre_format_html_hook (url, html)
    local changed = nil

    table.foreachi(pre_format_html_hooks,
                   function (i, fn)
                       local new,stop = fn(url,html)

                       if new then html=new changed=1 end
                       return stop
                   end)

   return changed and html
end

function add_pre_format_hook(name, fn)
  k = -1
  for i,v in pairs(pre_format_html_hooks_names) do
    if v == name then
      k = i
    end
  end
  if k ~= -1 then
    table.remove(pre_format_html_hooks_names, k)
    table.remove(pre_format_html_hooks, k)
  end
  table.insert(pre_format_html_hooks_names, name)
  table.insert(pre_format_html_hooks, fn)
end

goto_url_hooks = {n=0}
function goto_url_hook (url, current_url)
    table.foreachi(goto_url_hooks,
                   function (i, fn)
                       local new,stop = fn(url, current_url)

                       url = new

                       return stop
                   end)

   return url
end

follow_url_hooks = {n=0}
function follow_url_hook (url)
    table.foreachi(follow_url_hooks,
                   function (i, fn)
                       local new,stop = fn(url)

                       url = new

                       return stop
                   end)

   return url
end

quit_hooks = {n=0}
function quit_hook (url, html)
    table.foreachi(quit_hooks, function (i, fn) return fn() end)
end


----------------------------------------------------------------------
--  case-insensitive string.gsub
----------------------------------------------------------------------

-- Please note that this is not completely correct yet.
-- It will not handle pattern classes like %a properly.
-- FIXME: Handle pattern classes.

function gisub (s, pat, repl, n)
    pat = string.gsub (pat, '(%a)',
                function (v) return '['..string.upper(v)..string.lower(v)..']' end)
    if n then
        return string.gsub (s, pat, repl, n)
    else
        return string.gsub (s, pat, repl)
    end
end

----------------------------------------------------------------------
--  pre_format_html_hook
----------------------------------------------------------------------

function message(m)
    xdialog(m, function() end)
end

command_names = {}
command_functions = {}

function add_command(name, fn)
  local k = -1
  for i,v in pairs(command_names) do
    if v == name then
      k = i
    end
  end
  if k ~= -1 then
    table.remove(command_names, k)
    table.remove(command_functions, k)
  end
  table.insert(command_names, name)
  table.insert(command_functions, fn)
end

function command(c)
    args = {}
    for word in c:gmatch("%S+") do table.insert(args, word) end
    for i,v in pairs(command_names) do
      if v == args[1] then
        return command_functions[i](args)
      end
    end
end

add_command("source", function(args) source(args[2]) end)
add_command("update", function(args) plug_update() end)

bind_key("main", ":", function () xdialog("", command) end )

----------------------------------------------------------------------
-- nolinks
----------------------------------------------------------------------

add_pre_format_hook("nolinks", function (url, html)
  html, n = string.gsub (html, '<link[^>]*>', '')
  return ((n > 0) and html), nil
end)
