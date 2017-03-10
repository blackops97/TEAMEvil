--Begin Tools.lua :)
local SUDO = 113644348 -- هنا خلي ايديك<===
local function index_function(user_id)
  for k,v in pairs(_config.admins) do
    if user_id == v[1] then
    	print(k)
      return k
    end
  end
  -- If not found
  return false
end

local function getindex(t,id) 
for i,v in pairs(t) do 
if v == id then 
return i 
end 
end 
return nil 
end 

local function already_sudo(user_id)
  for k,v in pairs(_config.sudo_users) do
    if user_id == v then
      return k
    end
  end
  -- If not found
  return false
end

local function reload_plugins( ) 
  plugins = {} 
  load_plugins() 
end

local function sudolint(msg)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
local sudo_users = _config.sudo_users
  if not lang then
 text = "*🔎 List of sudo users :*\n"
   else
 text = "*🔎 قائمه المطورين : \n"
  end
for i=1,#sudo_users do
    text = text..i.." - "..sudo_users[i].."\n"
end
return text
end

local function adminlist(msg)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
local sudo_users = _config.sudo_users
  if not lang then
 text = '*List of bot admins :*\n'
   else
text = "*🔎 قائمه الاداريين : *\n"
  end
		  	local compare = text
		  	local i = 1
		  	for v,user in pairs(_config.admins) do
			    text = text..i..'- '..(user[2] or '')..' ➢ ('..user[1]..')\n'
		  	i = i +1
		  	end
		  	if compare == text then
   if not lang then
		  	text = '_🔎No_ *admins* _available_'
      else
		  		text = '*   🔎 لا يوجد اداريين  *'
           end
		  	end
		  	return text
    end

local function action_by_reply(arg, data)
    local cmd = arg.cmd
if not tonumber(data.sender_user_id_) then return false end
    if data.sender_user_id_ then
    if cmd == "رفع اداري" then
local function adminprom_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if is_admin1(tonumber(data.id_)) then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "* 🔎| User 😗 "..user_name.."\n *🔎| ID : "..data.id_.."*\n _is already an_ *admin*", 0, "md")
  else
    return  tdcli.sendMessage(arg.chat_id, "", 0, "* 🔎| User 😗 "..user_name.."\n *🔎| ID : "..data.id_.."*\n *❗️هوه بالفعل اداري 🔘", 0, "md")
      end
   end
	    table.insert(_config.admins, {tonumber(data.id_), user_name})
		save_config()
     if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "* 🔎| User 😗 "..user_name.."\n *🔎| ID : "..data.id_.."*\n _has been promoted as_ *admin*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "* 🔎| User 😗 "..user_name.."\n *🔎| ID : "..data.id_.."*\n تم رفعه اداري 🔘", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, adminprom_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "تنزيل اداري" then
local function admindem_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
	local nameid = index_function(tonumber(data.id_))
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not is_admin1(data.id_) then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "* 🔎| User 😗 "..user_name.."\n *🔎| ID : "..data.id_.."*\n _is not a_ *admin*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "* 🔎| User 😗 "..user_name.."\n *🔎| ID : "..data.id_.."*\n *❗️تم بالفعل تنزيله من الاداره🔘", 0, "md")
      end
   end
		table.remove(_config.admins, nameid)
		save_config()
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "* 🔎| User 😗 "..user_name.."\n *🔎| ID : "..data.id_.."*\n _has been demoted from_ *admin*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "* 🔎| User 😗 "..user_name.."\n *🔎| ID : "..data.id_.."*\n *❗️تم تنزيله من الاداره🔘", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, admindem_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "رفع مطور" then
local function visudo_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if already_sudo(tonumber(data.id_)) then
  if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already a_ *sudoer*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "* 🔎| User 😗 "..user_name.."\n *🔎| ID : "..data.id_.."*\n _❗️هوه بالفعل مطور 🔘_", 0, "md")
      end
   end
          table.insert(_config.sudo_users, tonumber(data.id_))
		save_config()
     reload_plugins(true)
  if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "* 🔎| User 😗 "..user_name.."\n *🔎| ID : "..data.id_.."*\n _is now_ *sudoer*", 0, "md")
  else
    return tdcli.sendMessage(arg.chat_id, "", 0, "* 🔎| User 😗 "..user_name.."\n *🔎| ID : "..data.id_.."*\n _❗️تم رفعه مطور_", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, visudo_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "تنزيل مطور" then
local function desudo_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
     if not already_sudo(data.id_) then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "* 🔎| User 😗 "..user_name.."\n *🔎| ID : "..data.id_.."*\n _is not a_ *sudoer*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "* 🔎| User 😗 "..user_name.."\n *🔎| ID : "..data.id_.."*\n _❗️تم بالفعل تنزيله من المطورين🔘_", 0, "md") 
      end
   end
          table.remove(_config.sudo_users, getindex( _config.sudo_users, tonumber(data.id_)))
		save_config()
     reload_plugins(true) 
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "* 🔎| User 😗 "..user_name.."\n *🔎| ID : "..data.id_.."*\n _is no longer a_ *sudoer*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "* 🔎| User 😗 "..user_name.."\n *🔎| ID : "..data.id_.."*\n _❗️تم تنزيله من المطورين 🔘_", 0, "md") 
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, desudo_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
else
    if lang then
  return tdcli.sendMessage(data.chat_id_, "", 0, "*🔎 لا يوجد", 0, "md")
   else
  return tdcli.sendMessage(data.chat_id_, "", 0, "*User Not Found*", 0, "md")
      end
   end
end

local function action_by_username(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local cmd = arg.cmd
if not arg.username then return false end
    if data.id_ then
if data.type_.user_.username_ then
user_name = '@'..check_markdown(data.type_.user_.username_)
else
user_name = check_markdown(data.title_)
end
    if cmd == "رفع اداري" then
if is_admin1(tonumber(data.id_)) then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "* 🔎| User 😗 "..user_name.."\n *🔎| ID : "..data.id_.."*\n _is already a_ *admin*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "* 🔎| User 😗 "..user_name.."\n *🔎| ID : "..data.id_.."*\n _❗️هوه بالفعل اداري🔘 _", 0, "md")
      end
   end
		table.remove(_config.admins, nameid)
		save_config()
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "* 🔎| User 😗 "..user_name.."\n *🔎| ID : "..data.id_.."*\n _is Now a_ *admin*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "* 🔎| User 😗 "..user_name.."\n *🔎| ID : "..data.id_.."*\n _❗️تم رفعه اداري 🔘_", 0, "md")
   end
end
    if cmd == "تنزيل اداري" then
	local nameid = index_function(tonumber(data.id_))
if not is_admin1(data.id_) then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "* 🔎| User 😗 "..user_name.."\n *🔎| ID : "..data.id_.."*\n _is not a_ *admin*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "* 🔎| User 😗 "..user_name.."\n *🔎| ID : "..data.id_.."*\n _❗️تم بالفعل تنزيله من الادارين🔘_", 0, "md")
      end
   end
		table.remove(_config.admins, nameid)
		save_config()
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "* 🔎| User 😗 "..user_name.."\n *🔎| ID : "..data.id_.."*\n _has been demoted from_ *admin*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "* 🔎| User 😗 "..user_name.."\n *🔎| ID : "..data.id_.."*\n _❗️تم تنزيله من الاداره 🔘_", 0, "md")
   end
end
    if cmd == "رفع مطور" then
if already_sudo(tonumber(data.id_)) then
  if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "* 🔎| User 😗 "..user_name.."\n *🔎| ID : "..data.id_.."*\n _is already a_ *sudoer*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "* 🔎| User 😗 "..user_name.."\n *🔎| ID : "..data.id_.."*\n ❗️هوه بالفعل مطور 🔘", 0, "md")
      end
   end
          table.insert(_config.sudo_users, tonumber(data.id_))
		save_config()
     reload_plugins(true)
  if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "* 🔎| User 😗 "..user_name.."\n *🔎| ID : "..data.id_.."*\n _is now_ *sudoer*", 0, "md")
  else
    return tdcli.sendMessage(arg.chat_id, "", 0, "* 🔎| User 😗 "..user_name.."\n *🔎| ID : "..data.id_.."*\n ❗️تم رفعه مطور 🔘", 0, "md")
   end
end
    if cmd == "تنزيل مطور" then
     if not already_sudo(data.id_) then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "* 🔎| User 😗 "..user_name.."\n *🔎| ID : "..data.id_.."*\n _is not a_ *sudoer*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "* 🔎| User 😗 "..user_name.."\n *🔎| ID : "..data.id_.."*\n ❗️تم بالفعل تنزيله من المطورين 🔘", 0, "md")
      end
   end
          table.remove(_config.sudo_users, getindex( _config.sudo_users, tonumber(data.id_)))
		save_config()
     reload_plugins(true) 
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "* 🔎| User 😗 "..user_name.."\n *🔎| ID : "..data.id_.."*\n _is no longer a_ *sudoer*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "* 🔎| User 😗 "..user_name.."\n *🔎| ID : "..data.id_.."*\n❗️ تم تنزيله من المطورين 🔘", 0, "md")
      end
   end
else
    if lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_🔎 لا يوجد _", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "*User Not Found*", 0, "md")
      end
   end
end

local function action_by_id(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local cmd = arg.cmd
if not tonumber(arg.user_id) then return false end
   if data.id_ then
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
    if cmd == "رفع اداري" then
if is_admin1(tonumber(data.id_)) then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "* 🔎| User 😗 "..user_name.."\n *🔎| ID : "..data.id_.."*\n _is already a_ *admin*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "* 🔎| User 😗 "..user_name.."\n *🔎| ID : "..data.id_.."*\n *❗️هوه بالفعل اداري 🔘", 0, "md")
      end
   end
		table.remove(_config.admins, nameid)
		save_config()
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "* 🔎| User 😗 "..user_name.."\n *🔎| ID : "..data.id_.."*\n _is Now a_ *admin*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "* 🔎| User 😗 "..user_name.."\n *🔎| ID : "..data.id_.."*\n *❗️تم رفعه اداري 🔘", 0, "md")
   end
end
    if cmd == "تنزيل اداري" then
	local nameid = index_function(tonumber(data.id_))
if not is_admin1(data.id_) then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "* 🔎| User 😗 "..user_name.."\n *🔎| ID : "..data.id_.."*\n _is not a_ *admin*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "* 🔎| User 😗 "..user_name.."\n *🔎| ID : "..data.id_.."*\n *❗️هوه بالفعل ليس اداري 🔘*", 0, "md")
      end
   end
		table.remove(_config.admins, nameid)
		save_config()
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "* 🔎| User 😗 "..user_name.."\n *🔎| ID : "..data.id_.."*\n _has been demoted from_ *admin*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "* 🔎| User 😗 "..user_name.."\n *🔎| ID : "..data.id_.."*\n *❗️تم تنزيله من الاداره🔘", 0, "md")
   end
end
    if cmd == "رفع مطور" then
if already_sudo(tonumber(data.id_)) then
  if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "* 🔎| User 😗 "..user_name.."\n *🔎| ID : "..data.id_.."*\n _is already a_ *sudoer*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "* 🔎| User 😗 "..user_name.."\n *🔎| ID : "..data.id_.."*\n _❗️هوه بالفعل مطور 🔘_", 0, "md")
      end
   end
          table.insert(_config.sudo_users, tonumber(data.id_))
		save_config()
     reload_plugins(true)
  if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "* 🔎| User 😗 "..user_name.."\n *🔎| ID : "..data.id_.."*\n _is now_ *sudoer*", 0, "md")
  else
    return tdcli.sendMessage(arg.chat_id, "", 0, "* 🔎| User 😗 "..user_name.."\n *🔎| ID : "..data.id_.."*\n _❗️تم رفعه مطور 🔎_", 0, "md")
   end
end
    if cmd == "تنزيل مطور" then
     if not already_sudo(data.id_) then
   if not lang then
   return tdcli.sendMessage(arg.chat_id, "", 0, "* 🔎| User 😗 "..user_name.."\n *🔎| ID : "..data.id_.."*\n _is not a_ *sudoer*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "* 🔎| User 😗 "..user_name.."\n *🔎| ID : "..data.id_.."*\n _❗️هوه بالفعل ليس مطور 🔘_", 0, "md")
      end
   end
          table.remove(_config.sudo_users, getindex( _config.sudo_users, tonumber(data.id_)))
		save_config()
     reload_plugins(true) 
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "* 🔎| User 😗 "..user_name.."\n *🔎| ID : "..data.id_.."*\n _is no longer a_ *sudoer*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "* 🔎| User 😗 "..user_name.."\n *🔎| ID : "..data.id_.."*\n _❗️تم تنزيله من المطورين 🔘_", 0, "md")
      end
   end
else
    if lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_🔎 لا يوجد _", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "*User Not Found*", 0, "md")
      end
   end
end

local function th3evil(msg, matches)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
 if tonumber(msg.sender_user_id_) == SUDO then
if matches[1] == "رفع مطور" then
if not matches[2] and tonumber(msg.reply_to_message_id_) ~= 0 then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.chat_id_,
      message_id_ = msg.reply_to_message_id_
    }, action_by_reply, {chat_id=msg.chat_id_,cmd="رفع مطور"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.chat_id_,user_id=matches[2],cmd="رفع مطور"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.chat_id_,username=matches[2],cmd="رفع مطور"})
      end
   end
if matches[1] == "تنزيل مطور" then
if not matches[2] and tonumber(msg.reply_to_message_id_) ~= 0 then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.chat_id_,
      message_id_ = msg.reply_to_message_id_
    }, action_by_reply, {chat_id=msg.chat_id_,cmd="تنزيل مطور"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.chat_id_,user_id=matches[2],cmd="تنزيل مطور"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.chat_id_,username=matches[2],cmd="تنزيل مطور"})
      end
   end
end
if matches[1] == "رفع اداري" and is_sudo(msg) then
if not matches[2] and tonumber(msg.reply_to_message_id_) ~= 0 then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.chat_id_,
      message_id_ = msg.reply_to_message_id_
    }, action_by_reply, {chat_id=msg.chat_id_,cmd="رفع اداري"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.chat_id_,user_id=matches[2],cmd="رفع اداري"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.chat_id_,username=matches[2],cmd="رفع اداري"})
      end
   end
if matches[1] == "تنزيل اداري" and is_sudo(msg) then
if not matches[2] and tonumber(msg.reply_to_message_id_) ~= 0 then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.chat_id_,
      message_id_ = msg.reply_to_message_id_
    }, action_by_reply, {chat_id=msg.chat_id_,cmd="تنزيل اداري"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.chat_id_,user_id=matches[2],cmd="تنزيل اداري"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.chat_id_,username=matches[2],cmd="تنزيل اداري"})
      end
   end

if matches[1] == 'انشاء مجموعه' and is_admin(msg) then
local text = matches[2]
tdcli.createNewGroupChat({[0] = msg.sender_user_id_}, text)
  if not lang then
return '_Group Has Been Created!_'
  else
return '_🔎 تم انشاء المجموعه_'
   end
end

if matches[1] == 'ترقيه سوبر' and is_admin(msg) then
local text = matches[2]
tdcli.createNewChannelChat({[0] = msg.sender_user_id_}, text)
   if not lang then 
return '_SuperGroup Has Been Created!_'
  else
return '_🔎 تم ترقيه المجموعه 🔘_'
   end
end

if matches[1] == 'صنع خارقه' and is_admin(msg) then
local id = msg.chat_id_
tdcli.migrateGroupChatToChannelChat(id)
  if not lang then
return '_Group Has Been Changed To SuperGroup!_'
  else
return '_🔎 تم انشاء المجموعه🔘_'
   end
end

if matches[1] == 'ادخل' and is_admin(msg) then
tdcli.importChatInviteLink(matches[2])
   if not lang then
return '*🔘Done!*'
  else
return '*🔘تــم!*'
  end
end

if matches[1] == 'ضع اسم البوت' and is_sudo(msg) then
tdcli.changeName(matches[2])
   if not lang then
return '_Bot Name Changed To:_ *'..matches[2]..'*'
  else
return '*🔎|تم تغيير اسم البوت \n🔘| الاسم الجديد : *'..matches[2]..'*'
   end
end

if matches[1] == 'ضع معرف البوت' and is_sudo(msg) then
tdcli.changeUsername(matches[2])
   if not lang then
return '*🔎| Bot Username Changed To *\n*🔎| username 😗 @'..matches[2]
  else
return '*🔧| تم تعديل معرف البوت *\n* 🔎| المعرف الجديد 😗 @'..matches[2]..''
   end
end

if matches[1] == 'مسح معرف البوت' and is_sudo(msg) then
tdcli.changeUsername('')
   if not lang then
return '*🔘Done!*'
  else
return '_🔘تم حذف معرف البوت _'
  end
end

if matches[1] == 'الماركدوان' then
if matches[2] == 'تفعيل' then
redis:set('markread','on')
   if not lang then
return '_Markread >_ *ON*'
else
return '_تم تفعيل الماركدوات  🔎_'
   end
end
if matches[2] == 'تعطيل' then
redis:set('markread','off')
  if not lang then
return '_Markread >_ *OFF*'
   else
return '_تم تعطيل الماركدوات  🔎_'
      end
   end
end

if matches[1] == 'bc' and is_admin(msg) then		
tdcli.sendMessage(matches[2], 0, 0, matches[3], 0)	end	

if matches[1] == 'اذاعه' and is_sudo(msg) then		
local data = load_data(_config.moderation.data)		
local bc = matches[2]			
for k,v in pairs(data) do				
tdcli.sendMessage(k, 0, 0, bc, 0)			
end	
end

if matches[1] == 'المطورين' and is_sudo(msg) then
return sudolist(msg)
    end
if matches[1] == 'المطور' then
return tdcli.sendMessage(msg.chat_id_, msg.id_, 1, _config.info_text, 1, 'html')
    end
if matches[1] == 'الاداريين' and is_admin(msg) then
return adminlist(msg)
    end
     if matches[1] == 'المغادره' and is_admin(msg) then
  tdcli.changeChatMemberStatus(chat, our_id, 'Left', dl_cb, nil)
   end
     if matches[1] == 'الخروج التلقائي' and is_admin(msg) then
local hash = 'auto_leave_bot'
--Enable Auto Leave
     if matches[2] == 'تفعيل' then
    redis:del(hash)
   return 'Auto leave has been enabled'
--Disable Auto Leave
     elseif matches[2] == 'تعطيل' then
    redis:set(hash, true)
   return 'Auto leave has been disabled'
--Auto Leave Status
      elseif matches[2] == 'الحاله' then
      if not redis:get(hash) then
   return 'Auto leave is enable'
       else
   return 'Auto leave is disable'
         end
      end
   end
end
return { 
patterns = { 
"^(رفع مطور)$", 
"^(تنزيل مطور)$",
"^(المطوريين)$",
"^(رفع مطور) (.*)$", 
"^(تنزيل مطور) (.*)$",
"^(رفع اداري)$", 
"^(تنزيل اداري)$",
"^(الاداريين)$",
"^(رفع اداري) (.*)$", 
"^(تنزيل اداري) (.*)$",
"^(المغادره)$",
"^(الخروج التلقائي) (.*)$", 
"^(المطور)$",
"^(انشاء مجموعه) (.*)$",
"^(ترقيه سوبر) (.*)$",
"^(صنع خارقه)$",
"^(ادخل) (.*)$",
"^(ضع اسم البوت) (.*)$",
"^(ضع معرف البوت) (.*)$",
"^(مسح معرف البوت) (.*)$",
"^(الماركدوان) (.*)$",
"^(bc) (%d+) (.*)$",
"^(تفعيل) (.*)$",
"^(تعطيل) (.*)$",
"^(اذاعه) (.*)$",
}, 
run = th3evil
}
