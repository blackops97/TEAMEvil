local function pre_process(msg)
chat = msg.chat_id_
user = msg.sender_user_id_
	local function check_newmember(arg, data)
		test = load_data(_config.moderation.data)
		lock_bots = test[arg.chat_id]['settings']['lock_bots']
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    if data.type_.ID == "UserTypeBot" then
      if not is_owner(arg.msg) and lock_bots == 'yes' then
kick_user(data.id_, arg.chat_id)
end
end
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if is_banned(data.id_, arg.chat_id) then
   if not lang then
	tdcli.sendMessage(arg.chat_id, arg.msg_id, 0, "_User_ "..user_name.." *[ "..data.id_.." ]* _is banned_", 0, "md")
   else
		tdcli.sendMessage(arg.chat_id, arg.msg_id, 0, "_العضوو_ "..user_name.." *[ "..data.id_.." ]* _❗️تم حظره 🔘_", 0, "md")
end
kick_user(data.id_, arg.chat_id)
end
if is_gbanned(data.id_) then
     if not lang then
		tdcli.sendMessage(arg.chat_id, arg.msg_id, 0, "_User_ "..user_name.." *[ "..data.id_.." ]* _is globally banned_", 0, "md")
    else
		tdcli.sendMessage(arg.chat_id, arg.msg_id, 0, "_العضو_ "..user_name.." *[ "..data.id_.." ]* _❗️تم حظره عام 🔘_", 0, "md")
   end
kick_user(data.id_, arg.chat_id)
     end
	end
	if msg.adduser then
			tdcli_function ({
	      ID = "GetUser",
      	user_id_ = msg.adduser
    	}, check_newmember, {chat_id=chat,msg_id=msg.id_,user_id=user,msg=msg})
	end
	if msg.joinuser then
			tdcli_function ({
	      ID = "GetUser",
      	user_id_ = msg.joinuser
    	}, check_newmember, {chat_id=chat,msg_id=msg.id_,user_id=user,msg=msg})
	end
if is_silent_user(user, chat) then
del_msg(msg.chat_id_, msg.id_)
end
if is_banned(user, chat) then
del_msg(msg.chat_id_, tonumber(msg.id_))
    kick_user(user, chat)
   end
if is_gbanned(user) then
del_msg(msg.chat_id_, tonumber(msg.id_))
    kick_user(user, chat)
   end
end
local function action_by_reply(arg, data)
local hash = "gp_lang:"..data.chat_id_
local lang = redis:get(hash)
  local cmd = arg.cmd
if not tonumber(data.sender_user_id_) then return false end
if data.sender_user_id_ then
  if cmd == "حظر" then
local function ban_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
   if is_mod1(arg.chat_id, data.id_) then
  if not lang then
 return tdcli.sendMessage(arg.chat_id, "", 0, "_❗️You can't ban_ *mods,owners and bot admins🔘*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "*❗️ لا تستطيع حظر المدراء او الادمنيه🚫*", 0, "md")
         end
     end
if administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] then
    if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."*❗️ _is already_ *banned🔘*", 0, "md")
   else
     return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *❗️ تم بالفعل حظره 🔘*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   kick_user(data.id_, arg.chat_id)
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."*❗️ _has been_ *banned*🔘", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *❗️ تم حظره عام 🔘*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, ban_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
   if cmd == "الغاء الحظر" then
local function unban_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not_ *banned*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *❗️ تم بالفعل الغاء حظره 🔘*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."*❗️ _has been_ *unbanned🔘*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *❗️ تم الغاء حظره 🔘*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, unban_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
  if cmd == "كتم" then
local function silent_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
   if is_mod1(arg.chat_id, data.id_) then
  if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_You can't silent_ *mods,owners and bot admins*", 0, "md")
    else
 return tdcli.sendMessage(arg.chat_id, "", 0, "*❗️ لا تستطيع كتم المدراء او الادمنيه🚫*", 0, "md")
       end
     end
if administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] then
    if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."*❗️ _is already_ *silent🔘*", 0, "md")
  else
     return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *❗️تم بالفعل كتمه 🔘*", 0, "md")
     end
   end
administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
  if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* ❗️_added to_ *silent users list🔘*", 0, "md")
  else
     return tdcli.sendMessage(arg.chat_id, "", 0, "❗️_العضو_ "..user_name.." *"..data.id_.."* *تم كتمه🔘 *", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, silent_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
  if cmd == "الغاء الكتم" then
local function unsilent_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* ❗️_is not_ *silent🔘*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_العضو_ "..user_name.." *"..data.id_.."* *❗️تم بالفعل الغاء الكتم عنه 🔘*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
    if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."*❗️ _removed from_ *silent users list🔘*", 0, "md")
  else
     return tdcli.sendMessage(arg.chat_id, "", 0, "❗️_العضو_ "..user_name.." *"..data.id_.."* *تم الغاء الكتم عنه 🔘*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, unsilent_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
  if cmd == "حظر عام" then
local function gban_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
  if not administration['gban_users'] then
    administration['gban_users'] = {}
    save_data(_config.moderation.data, administration)
    end
   if is_admin1(data.id_) then
  if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_❗️You can't_ *globally ban* _other admins🚫_", 0, "md")
  else
  return tdcli.sendMessage(arg.chat_id, "", 0, "*❗️ لا تستطيع حظر المدراء او الادمنيه🚫*", 0, "md")
        end
     end
if is_gbanned(data.id_) then
   if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "❗️_User_ "..user_name.." *"..data.id_.."* _is already_ *globally banned🔘*", 0, "md")
    else
     return tdcli.sendMessage(arg.chat_id, "", 0, "❗️_العضو_ "..user_name.." *"..data.id_.."* * تم بالفعل حظره عام 🔘*", 0, "md")
      end
   end
  administration['gban_users'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   kick_user(data.id_, arg.chat_id)
     if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "❗️_User_ "..user_name.." *"..data.id_.."* _has been_ *globally banned🔘*", 0, "md")
   else
     return tdcli.sendMessage(arg.chat_id, "", 0, "❗️_العضو_ "..user_name.." *"..data.id_.."* * تم حظره عام 🔘*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, gban_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
  if cmd == "الغاء العام" then
local function ungban_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
  if not administration['gban_users'] then
    administration['gban_users'] = {}
    save_data(_config.moderation.data, administration)
    end
if not is_gbanned(data.id_) then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "❗️_User_ "..user_name.." *"..data.id_.."* _is not_ *globally banned🔘*", 0, "md")
   else
     return tdcli.sendMessage(arg.chat_id, "", 0, "❗️_العضو_ "..user_name.." *"..data.id_.."* * تم بالفعل الغاء حظره العام🔘*", 0, "md")
      end
   end
  administration['gban_users'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
    if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "_❗️User_ "..user_name.." *"..data.id_.."* _has been_ *globally unbanned🔘*", 0, "md")
   else
     return tdcli.sendMessage(arg.chat_id, "", 0, "❗️_العضو_ "..user_name.." *"..data.id_.."* * تم الغاء حظره العام 🔘*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, ungban_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
  if cmd == "دي" then
   if is_mod1(data.chat_id_, data.sender_user_id_) then
   if not lang then
  return tdcli.sendMessage(data.chat_id_, "", 0, "_❗️You can't kick_ *mods,owners and bot admins🚫*", 0, "md")
    elseif lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "*❗️ لا تستطيع حظر المدراء او الادمنيه🚫*", 0, "md")
   end
  else
     kick_user(data.sender_user_id_, data.chat_id_)
     end
  end
  if cmd == "مسح الكل" then
   if is_mod1(data.chat_id_, data.sender_user_id_) then
   if not lang then
  return tdcli.sendMessage(data.chat_id_, "", 0, "❗️_You can't delete messages_ *mods,owners and bot admins🔘*", 0, "md")
   elseif lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "*❗️ لا تستطيع حذف رسائل المدراء او الادمنيه*🚫", 0, "md")
   end
  else
tdcli.deleteMessagesFromUser(data.chat_id_, data.sender_user_id_, dl_cb, nil)
   if not lang then
  return tdcli.sendMessage(data.chat_id_, "", 0, "❗️_All_ *messages* _of_ *[ "..data.sender_user_id_.." ]* _has been_ *deleted🔘*", 0, "md")
      elseif lang then
  return tdcli.sendMessage(data.chat_id_, "", 0, "*❗️رسائل العضو* *[ "..data.sender_user_id_.." ]* *تم حذفها 🔘*", 0, "md")
       end
    end
  end
else
    if lang then
  return tdcli.sendMessage(data.chat_id_, "", 0, "❗️_لم يتم العثور على العضو_⚠️", 0, "md")
   else
  return tdcli.sendMessage(data.chat_id_, "", 0, "*❗️User Not Found⚠️*", 0, "md")
      end
   end
end
local function action_by_username(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
  local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
if not arg.username then return false end
    if data.id_ then
if data.type_.user_.username_ then
user_name = '@'..check_markdown(data.type_.user_.username_)
else
user_name = check_markdown(data.title_)
end
  if cmd == "حظر" then
   if is_mod1(arg.chat_id, data.id_) then
  if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "❗️_You can't ban_ *mods,owners and bot admins🚫*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "*❗️ لا تستطيع حظر المدراء او الادمنيه🚫*", 0, "md")
         end
     end
if administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] then
    if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "❗️_User_ "..user_name.." *"..data.id_.."* _is already_ *banned🔘*", 0, "md")
   else
     return tdcli.sendMessage(arg.chat_id, "", 0, "❗️_العضو_ "..user_name.." *"..data.id_.."* * تم بالفعل حظره 🔘*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   kick_user(data.id_, arg.chat_id)
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "❗️_User_ "..user_name.." *"..data.id_.."* _has been_ *banned🔘*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "❗️_العضو_ "..user_name.." *"..data.id_.."* * تم حظره🔘*", 0, "md")
   end
end
   if cmd == "الغاء الحظر" then
if not administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_❗️User_ "..user_name.." *"..data.id_.."* _is not_ *banned🔘*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_❗️العضو_ "..user_name.." *"..data.id_.."* * تم بالفعل الغاء حظره 🔘*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_❗️User_ "..user_name.." *"..data.id_.."* _has been_ *unbanned🔘*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_❗️العضو_ "..user_name.." *"..data.id_.."* * تم الغاء حظره 🔘*", 0, "md")
   end
end
  if cmd == "كتم" then
   if is_mod1(arg.chat_id, data.id_) then
  if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_❗️You can't silent_ *mods,owners and bot admins🚫*", 0, "md")
    else
  return tdcli.sendMessage(arg.chat_id, "", 0, "*❗️ لا تستطيع كتم المدراء او الادمنيه🚫*", 0, "md")
       end
     end
if administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] then
    if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "_❗️User_ "..user_name.." *"..data.id_.."* _is already_ *silent🔘*", 0, "md")
  else
     return tdcli.sendMessage(arg.chat_id, "", 0, "❗️_العضو_ "..user_name.." *"..data.id_.."* *تم بالفعل كتمه 🔘*", 0, "md")
     end
   end
administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
  if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "❗️_User_ "..user_name.." *"..data.id_.."* _added to_ *silent users list🔘*", 0, "md")
  else
     return tdcli.sendMessage(arg.chat_id, "", 0, "❗️_العضو_ "..user_name.." *"..data.id_.."* *تم كتمه 🔘*", 0, "md")
   end
end
  if cmd == "الغاء الكتم" then
if not administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] then
   if not lang then
   return tdcli.sendMessage(arg.chat_id, "", 0, "❗️_User_ "..user_name.." *"..data.id_.."* _is not_ *silent🔘*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_❗️العضو_ "..user_name.." *"..data.id_.."* *تم بالفعل الغاء الكتم عنه 🔘*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
    if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "_❗️User_ "..user_name.." *"..data.id_.."* _removed from_ *silent users list🔘*", 0, "md")
  else
     return tdcli.sendMessage(arg.chat_id, "", 0, "_❗️العضو_ "..user_name.." *"..data.id_.."* *تم الغاء الكتم عنه 🔘*", 0, "md")
   end
end
  if cmd == "حظر عام" then
  if not administration['gban_users'] then
    administration['gban_users'] = {}
    save_data(_config.moderation.data, administration)
    end
   if is_admin1(data.id_) then
  if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_❗️You can't_ *globally ban* _other admins_🚫", 0, "md")
  else
  return tdcli.sendMessage(arg.chat_id, "", 0, "*❗️ لا تستطيع حظر المدراء او الادمنيه🚫*", 0, "md")
        end
     end
if is_gbanned(data.id_) then
   if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "_❗️User_ "..user_name.." *"..data.id_.."* _is already_ *globally banned🔘*", 0, "md")
    else
     return tdcli.sendMessage(arg.chat_id, "", 0, "_❗️العضو_ "..user_name.." *"..data.id_.."* * تم بالفعل حظره عام 🔘*", 0, "md")
      end
   end
  administration['gban_users'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   kick_user(data.id_, arg.chat_id)
     if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "_❗️User_ "..user_name.." *"..data.id_.."* _has been_ *globally banned🔘*", 0, "md")
   else
     return tdcli.sendMessage(arg.chat_id, "", 0, "_❗️العضو_ "..user_name.." *"..data.id_.."* * تم حظره عام 🔘*", 0, "md")
   end
end
  if cmd == "الغاء العام" then
  if not administration['gban_users'] then
    administration['gban_users'] = {}
    save_data(_config.moderation.data, administration)
    end
if not is_gbanned(data.id_) then
     if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "_❗️User_ "..user_name.." *"..data.id_.."* _is not_ *globally banned🔘*", 0, "md")
   else
     return tdcli.sendMessage(arg.chat_id, "", 0, "_❗️العضو_ "..user_name.." *"..data.id_.."* * تم بالفعل الغاء حظره العام 🔘*", 0, "md")
      end
   end
  administration['gban_users'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
    if not lang then
     return tdcli.sendMessage(arg.chat_id, "", 0, "_❗️User_ "..user_name.." *"..data.id_.."* _has been_ *globally unbanned🔘*", 0, "md")
   else
     return tdcli.sendMessage(arg.chat_id, "", 0, "_❗️العضو_ "..user_name.." *"..data.id_.."* * تم الغاء حظره العام 🔘*", 0, "md")
   end
end
  if cmd == "دي" then
   if is_mod1(arg.chat_id, data.id_) then
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_❗️You can't kick_ *mods,owners and bot admins🚫*", 0, "md")
    elseif lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "*❗️ لا تستطيع طرد المدراء او الادمنيه🚫*", 0, "md")
   end
  else
     kick_user(data.id_, arg.chat_id)
     end
  end
  if cmd == "مسح الكل" then
   if is_mod1(arg.chat_id, data.id_) then
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_❗️You can't delete messages_ *mods,owners and bot admins🚫*", 0, "md")
   elseif lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "*❗️ لا تستطيع حذف رسائل المدراء او الادمنيه🚫*", 0, "md")
   end
  else
tdcli.deleteMessagesFromUser(arg.chat_id, data.id_, dl_cb, nil)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "❗️_All_ *messages* _of_ "..user_name.." *[ "..data.id_.." ]* _has been_ *deleted🔘*", 0, "md")
      elseif lang then
  return tdcli.sendMessage(data.chat_id_, "", 0, "*❗️رسائل العضو* *[ "..data.sender_user_id_.." ]* *تم حذفها 🔘*", 0, "md")
       end
    end
  end
else
    if lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_❗️لم يتم العثور على العضو_🔘", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "*❗️User Not Found🔘*", 0, "md")
      end
   end
end
local function run(msg, matches)
local hash = "gp_lang:"..msg.chat_id_
local lang = redis:get(hash)
local data = load_data(_config.moderation.data)
chat = msg.chat_id_
user = msg.sender_user_id_
 if matches[1] == "دي" and is_mod(msg) then
if not matches[2] and tonumber(msg.reply_to_message_id_) ~= 0 then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.chat_id_,
      message_id_ = msg.reply_to_message_id_
    }, action_by_reply, {chat_id=msg.chat_id_,cmd="دي"})
end
  if matches[2] and string.match(matches[2], '^%d+$') then
   if is_mod1(msg.chat_id_, matches[2]) then
   if not lang then
    tdcli.sendMessage(msg.chat_id_, "", 0, "❗️_You can't kick mods,owners or bot admins🚫_", 0, "md")
   elseif lang then
     tdcli.sendMessage(msg.chat_id_, "", 0, "*❗️ لا تستطيع طرد المدراء اوالادمنيه🚫*", 0, "md")
         end
     else
kick_user(matches[2], msg.chat_id_)
      end
   end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.chat_id_,username=matches[2],cmd="دي"})
         end
      end
 if matches[1] == "مسح الكل" and is_mod(msg) then
if not matches[2] and tonumber(msg.reply_to_message_id_) ~= 0 then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.chat_id_,
      message_id_ = msg.reply_to_message_id_
    }, action_by_reply, {chat_id=msg.chat_id_,cmd="مسح الكل"})
end
  if matches[2] and string.match(matches[2], '^%d+$') then
   if is_mod1(msg.chat_id_, matches[2]) then
   if not lang then
return tdcli.sendMessage(msg.chat_id_, "", 0, "❗️_You can't delete messages mods,owners or bot admins🚫_", 0, "md")
     elseif lang then
   return tdcli.sendMessage(arg.chat_id, "", 0, "*❗️ لا تستطيع حذف رسائل المدراء او الادمنيه🚫*", 0, "md")
   end
     else
tdcli.deleteMessagesFromUser(msg.chat_id_, matches[2], dl_cb, nil)
    if not lang then
  return tdcli.sendMessage(msg.chat_id_, "", 0, "❗️_All_ *messages* _of_ *[ "..matches[2].." ]* _has been_ *deleted🔘*", 0, "md")
   elseif lang then
  return tdcli.sendMessage(data.chat_id_, "", 0, "*❗️رسائل العضو* *[ "..data.sender_user_id_.." ]* *تم حذفها 🔘*", 0, "md")
         end
      end
   end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.chat_id_,username=matches[2],cmd="مسح الكل"})
         end
      end
 if matches[1] == "حظر عام" and is_admin(msg) then
if not matches[2] and tonumber(msg.reply_to_message_id_) ~= 0 then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.chat_id_,
      message_id_ = msg.reply_to_message_id_
    }, action_by_reply, {chat_id=msg.chat_id_,cmd="حظر عام"})
end
  if matches[2] and string.match(matches[2], '^%d+$') then
   if is_admin1(matches[2]) then
   if not lang then
   return tdcli.sendMessage(msg.chat_id_, "", 0, "_❗️You can't globally ban other admins🚫_", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "*❗️ لا تستطيع حظر المدراء او الادمنيه🚫*", 0, "md")
        end
     end
   if is_gbanned(matches[2]) then
   if not lang then
  return tdcli.sendMessage(msg.chat_id_, "", 0, "❗️*User "..matches[2].." is already globally banned🔘*", 0, "md")
    else
  return tdcli.sendMessage(arg.chat_id, "", 0, "❗️_العضو_ "..user_name.." *"..data.id_.."* * تم بالفعل حظره عام 🔘*", 0, "md")
        end
     end
  data['gban_users'][tostring(matches[2])] = ""
    save_data(_config.moderation.data, data)
kick_user(matches[2], msg.chat_id_)
   if not lang then
 return tdcli.sendMessage(msg.chat_id_, msg.id_, 0, "*❗️User "..matches[2].." has been globally banned🔘*", 0, "md")
    else
 return tdcli.sendMessage(arg.chat_id, "", 0, "_❗️العضو_ "..user_name.." *"..data.id_.."* * تم حظره عام 🔘*", 0, "md")
      end
   end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.chat_id_,username=matches[2],cmd="حظر عام"})
      end
   end
 if matches[1] == "الغاء العام" and is_admin(msg) then
if not matches[2] and tonumber(msg.reply_to_message_id_) ~= 0 then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.chat_id_,
      message_id_ = msg.reply_to_message_id_
    }, action_by_reply, {chat_id=msg.chat_id_,cmd="الغاء العام"})
end
  if matches[2] and string.match(matches[2], '^%d+$') then
   if not is_gbanned(matches[2]) then
     if not lang then
   return tdcli.sendMessage(msg.chat_id_, "", 0, "*❗️User "..matches[2].." is not globally banned🔘*", 0, "md")
    else
   return tdcli.sendMessage(arg.chat_id, "", 0, "❗️_العضو_ "..user_name.." *"..data.id_.."* * تم بالفعل الغاء حظره العام 🔘*", 0, "md")
        end
     end
  data['gban_users'][tostring(matches[2])] = nil
    save_data(_config.moderation.data, data)
   if not lang then
return tdcli.sendMessage(msg.chat_id_, msg.id_, 0, "*❗️User "..matches[2].." has been globally unbanned🔘*", 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, "_❗️العضو_ "..user_name.." *"..data.id_.."* * تم الغاء حظره العام 🔘*", 0, "md")
      end
   end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.chat_id_,username=matches[2],cmd="الغاء العام"})
      end
   end
 if matches[1] == "حظر" and is_mod(msg) then
if not matches[2] and tonumber(msg.reply_to_message_id_) ~= 0 then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.chat_id_,
      message_id_ = msg.reply_to_message_id_
    }, action_by_reply, {chat_id=msg.chat_id_,cmd="حظر"})
end
  if matches[2] and string.match(matches[2], '^%d+$') then
   if is_mod1(msg.chat_id_, matches[2]) then
     if not lang then
    return tdcli.sendMessage(msg.chat_id_, "", 0, "_❗️You can't ban mods,owners or bot admins🚫_", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "*❗️ لا تستطيع حظر المدراء او الادمنيه🚫*", 0, "md")
        end
     end
   if is_banned(matches[2], msg.chat_id_) then
   if not lang then
  return tdcli.sendMessage(msg.chat_id_, "", 0, "_❗️User "..matches[2].." is already banned🔘_", 0, "md")
  else
  return tdcli.sendMessage(arg.chat_id, "", 0, "_❗️العضو_ "..user_name.." *"..data.id_.."* * تم بالفعل حظره 🔘*", 0, "md")
        end
     end
data[tostring(chat)]['banned'][tostring(matches[2])] = ""
    save_data(_config.moderation.data, data)
kick_user(matches[2], msg.chat_id_)
   if not lang then
return tdcli.sendMessage(msg.chat_id_, msg.id_, 0, "_❗️User "..matches[2].." has been banned🔘_", 0, "md")
  else
 return tdcli.sendMessage(arg.chat_id, "", 0, "_❗️العضو_ "..user_name.." *"..data.id_.."* * تم حظره 🔘*", 0, "md")
      end
end 
if matches[2] and not string.match(matches[2], '^%d+$') then
     tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.chat_id_,username=matches[2],cmd="حظر"})
      end
   end
 if matches[1] == "الغاء الحظر" and is_mod(msg) then
if not matches[2] and tonumber(msg.reply_to_message_id_) ~= 0 then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.chat_id_,
      message_id_ = msg.reply_to_message_id_
    }, action_by_reply, {chat_id=msg.chat_id_,cmd="الغاء الحظر"})
end
  if matches[2] and string.match(matches[2], '^%d+$') then
   if not is_banned(matches[2], msg.chat_id_) then
   if not lang then
   return tdcli.sendMessage(msg.chat_id_, "", 0, "_❗️User "..matches[2].." is not banned🔘_", 0, "md")
  else
   return tdcli.sendMessage(arg.chat_id, "", 0, "_❗️العضو_ "..user_name.." *"..data.id_.."* * تم بالفعل الغاء حظره 🔘*", 0, "md")
        end
     end
data[tostring(chat)]['banned'][tostring(matches[2])] = nil
    save_data(_config.moderation.data, data)
   if not lang then
return tdcli.sendMessage(msg.chat_id_, msg.id_, 0, "_❗️User "..matches[2].." has been unbanned🔘_", 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, "_❗️العضو_ "..user_name.." *"..data.id_.."* * تم الغاء حظره 🔘*", 0, "md")
      end
   end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.chat_id_,username=matches[2],cmd="الغاء الحظر"})
      end
   end
 if matches[1] == "كتم" and is_mod(msg) then
if not matches[2] and tonumber(msg.reply_to_message_id_) ~= 0 then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.chat_id_,
      message_id_ = msg.reply_to_message_id_
    }, action_by_reply, {chat_id=msg.chat_id_,cmd="كتم"})
end
  if matches[2] and string.match(matches[2], '^%d+$') then
   if is_mod1(msg.chat_id_, matches[2]) then
   if not lang then
   return tdcli.sendMessage(msg.chat_id_, "", 0, "_❗️You can't silent mods,leaders or bot admins🔘_", 0, "md")
 else
   return tdcli.sendMessage(arg.chat_id, "", 0, "*❗️لا تستطيع حظر المدراء او الادمنيه🔘*", 0, "md")
        end
     end
   if is_silent_user(matches[2], chat) then
   if not lang then
   return tdcli.sendMessage(msg.chat_id_, "", 0, "_❗️User "..matches[2].." is already silent🔘_", 0, "md")
   else
   return tdcli.sendMessage(arg.chat_id, "", 0, "_❗️العضو_ "..user_name.." *"..data.id_.."* *تم بالفعل كتمه 🔘*", 0, "md")
        end
     end
data[tostring(chat)]['is_silent_users'][tostring(matches[2])] = ""
    save_data(_config.moderation.data, data)
    if not lang then
 return tdcli.sendMessage(msg.chat_id_, msg.id_, 0, "_❗️User "..matches[2].." added to silent users list🔘_", 0, "md")
  else
 return tdcli.sendMessage(arg.chat_id, "", 0, "_❗️العضو_ "..user_name.." *"..data.id_.."* *تم كتمه 🔘*", 0, "md")
      end
   end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.chat_id_,username=matches[2],cmd="كتم"})
      end
   end
 if matches[1] == "الغاء الكتم" and is_mod(msg) then
if not matches[2] and tonumber(msg.reply_to_message_id_) ~= 0 then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.chat_id_,
      message_id_ = msg.reply_to_message_id_
    }, action_by_reply, {chat_id=msg.chat_id_,cmd="الغاء الكتم"})
end
  if matches[2] and string.match(matches[2], '^%d+$') then
   if not is_silent_user(matches[2], chat) then
     if not lang then
     return tdcli.sendMessage(msg.chat_id_, "", 0, "_❗️User "..matches[2].." is not silent🔘_", 0, "md")
   else
     return tdcli.sendMessage(arg.chat_id, "", 0, "_❗️العضو_ "..user_name.." *"..data.id_.."* *تم بالفعل الغاء الكتم عنه 🔘*", 0, "md")
        end
     end
data[tostring(chat)]['is_silent_users'][tostring(matches[2])] = nil
    save_data(_config.moderation.data, data)
   if not lang then
 return tdcli.sendMessage(msg.chat_id_, msg.id_, 0, "_❗️User "..matches[2].." removed from silent users list🔘_", 0, "md")
  else
 return tdcli.sendMessage(arg.chat_id, "", 0, "_❗️العضو_ "..user_name.." *"..data.id_.."* *تم الغاء الكتم عنه 🔘*", 0, "md")
      end
   end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.chat_id_,username=matches[2],cmd="الغاء الكتم"})
      end
   end
		if matches[1]:lower() == 'مسح' and is_owner(msg) then
			if matches[2] == 'قائمه الحظر' then
				if next(data[tostring(chat)]['banned']) == nil then
     if not lang then
				return "_❗️No_ *banned* _users in this group⁉️_"
   else
					return "*❗️لا يوجد مستخدمين محظورين في هذه المجموعه⁉️*"
              end
				end
				for k,v in pairs(data[tostring(chat)]['banned']) do
					data[tostring(chat)]['banned'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
     if not lang then
				return "_❗️All_ *banned* _users has been unbanned🔘_"
    else
				return "*❗️تم الغاء الحظر عن جميع المستخدمين في هذه المجموعه🔘*"
           end
			end
			if matches[2] == 'قائمه الكتم' then
				if next(data[tostring(chat)]['is_silent_users']) == nil then
        if not lang then
			return "❗️_No_ *silent* _users in this group🔘_"
   else
					return "*❗️لا يوجد مستخدمين مكتومين في هذه المجموعه🔘*"
             end
				end
				for k,v in pairs(data[tostring(chat)]['is_silent_users']) do
					data[tostring(chat)]['is_silent_users'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				    end
       if not lang then
				return "*❗️Silent list* _has been cleaned🔘_"
   else
				return "*❗️تم مسح قائمه الكتم🔘*"
               end
			    end
        end
		if matches[1]:lower() == 'مسح' and is_sudo(msg) then
			if matches[2] == 'قائمه العام' then
				if next(data['gban_users']) == nil then
    if not lang then
					return "❗️_No_ *globally banned* _users available_⁉️"
   else
					return "*❗️لا يوجد مستخدمين محظورين عام في المجموعه ⁉️*"
             end
				end
				for k,v in pairs(data['gban_users']) do
					data['gban_users'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
      if not lang then
				return "❗️_All_ *globally banned* _users has been unbanned🔘_"
   else
				return "*❗️تم الغاء الحظر عن جميع المستخدمين المحظورين عام من المجموعه🔘*"
          end
			end
     end
if matches[1] == "قائمه العام" and is_admin(msg) then
  return gbanned_list(msg)
 end
if matches[1] == "قائمه الكتم" and is_mod(msg) then
  return silent_users_list(chat)
 end
if matches[1] == "قائمه الحظر" and is_mod(msg) then
  return banned_list(chat)
 end
end
return {
	patterns = {
"^(حظر عام)$",
"^(حظر عام) (.*)$",
"^(الغاء العام)$",
"^(الغاء العام) (.*)$",
"^(قائمه العام)$",
"^(حظر)$",
"^(حظر) (.*)$",
"^(الغاء الحظر)$",
"^(الغاء الحظر) (.*)$",
"^(قائمه الحظر)$",
"^(كتم)$",
"^(كتم) (.*)$",
"^(الغاء الكتم)$",
"^(الغاء الكتم) (.*)$",
"^(قائمه الكتم)$",
"^(دي)$",
"^(دي) (.*)$",
"^(مسح الكل)$",
"^(مسح الكل) (.*)$",
"^(مسح) (.*)$",

},
run = run,
pre_process = pre_process
}
