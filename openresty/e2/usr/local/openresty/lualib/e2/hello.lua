local _M = {}

function _M.greet(name)
    ngx.say("Hello ", name)
end

return _M