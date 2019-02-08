local packets = require('packets')
require('strings')

_addon.name = 'SendAllTarget'
_addon.version = '1.0'
_addon.author = 'Selindrile, Thanks and apologies to Arcon for abusing his code.'
_addon.commands = {'sendalltarget','sendat','sat'}

windower.register_event('addon command',function (cmd,...)
	if cmd == nil then return
	elseif cmd == 'alltarget' then
		local target = windower.ffxi.get_mob_by_target('t')
		windower.send_command('send @all sendalltarget target ' .. tostring(target.id))
	elseif cmd == 'target' then
		local id = tonumber(...)
		local target = windower.ffxi.get_mob_by_id(id)
		if not target then
			return
		end
		
		local player = windower.ffxi.get_player()
		packets.inject(packets.new('incoming', 0x058, {
			['Player'] = player.id,
			['Target'] = target.id,
			['Player Index'] = player.index,
		}))
	elseif cmd == 'command' then
		local command = ...
		local mobid = windower.ffxi.get_mob_by_target('t')
		if mobid and mobid.id then
			windower.send_command('send @all '..command..' '..mobid.id..'')
		end
    end
end)