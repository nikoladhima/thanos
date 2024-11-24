local Player = game.Players.LocalPlayer
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({
    Name = "Vexxis Alpha Key System",
    LoadingTitle = "Initializing..",
    LoadingSubtitle = "Loading Key System..",
    Theme = "Amethyst",
    ConfigurationSaving = {
    Enabled = true,
    FolderName = nil,
    FileName = "Vexxis"
    },
    Discord ={
        Enabled = true, -- Prompt the user to join your Discord server if their executor supports it
        Invite = "uusn8yjs2z", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
        RememberJoins = true -- Set this to false to make them join the discord every time they load it up
    },
    KeySystem = false,
    KeySettings = {
        Title = "",
        Subtitle = "",
        Note = "",
        Key = ""
    }
})

local function BinaryToString(BinaryString)
	local String = ""
	
	for i, Binary in ipairs(BinaryString:split' ') do 
		local Byte = tonumber(Binary, 2) 
		String = String .. string.char(Byte) 
	end
	
	return String
end

local key = BinaryToString(game:HttpGet('https://pastebin.com/raw/FPPUfCbd'))
local keySystem = Window:CreateTab("Key System")

local Input
function DefaultData(Path,Option)
	if isfile("Vexxis/" .. Path) ~= false then
		return print("Option already exists")
	else
		writefile("Vexxis/" .. Path,Option)
		return print("Set default data")
	end
end

function ChangeData(Path,Option,WithFolder)
	if WithFolder == false then
		if isfile(Path) ~= false then
			writefile(Path,Option)
		end
	else 
		if isfile("Vexxis/" .. Path) ~= false then
			writefile("Vexxis/" .. Path,Option)
		end
	end
end

function ReturnData(Path,WithFolder)
	if WithFolder == false then
		if isfile(Path) ~= false then
			return readfile(Path)
		end
	else
		if isfile("Vexxis/" .. Path) ~= false then
			return readfile("Vexxis/" .. Path)
		end
		return nil
	end
end

if not isfolder("Vexxis") then
	makefolder("Vexxis")
    DefaultData("SavedKey.key","NoKeyEntered")
else
    DefaultData("SavedKey.key","NoKeyEntered")
end

function MakeScriptHub()
    loadstring(game:HttpGet("https://pastebin.com/dbpfU8Cf"))()
end

if ReturnData("SavedKey.key") == key then
    Rayfield:Destroy()
    MakeScriptHub()
elseif ReturnData("SavedKey.key") ~= "NoKeyEntered" then
    Rayfield:Notify({
        Name = "Key changed",
        Content = "The key has changed check discord for the new key",
        Duration = 3.5,
        Image = "rbxassetid://4483345998",
    })
else
        ChangeData("SavedKey.key","NoKeyEntered")
end


function IncorrectKeyNotification()
    Rayfield:Notify({
        Name = "Incorrect Key!",
        Content = "You have entered the incorrect key!",
        Duration = 3,
        Image = "rbxassetid://4483345998",
    })
end

keySystem:CreateInput({
    Name = "Enter key here",
    PlaceholderText = "",
    RemoveTextAfterFocusLost = false,
    Callback = function(Value)
        Input = tostring(Value)
    end
})

keySystem:CreateButton({
    Name = "Check Key",
    Description = "Click to check key",
    Callback = function()
        print(Input)
        if Input == key then
          ChangeData("SavedKey.key",key)
          task.wait()
          Rayfield:Destroy()
          MakeScriptHub()
      else
          IncorrectKeyNotification()
  end
    end
})

keySystem:CreateButton({
    Name = "Get key",
    Description = "",
    Callback = function()
        if httprequest then
            task.spawn(function()
            httprequest({
                Url = 'http://127.0.0.1:6463/rpc?v=1',
                Method = 'POST',
                Headers = {
                    ['Content-Type'] = 'application/json',
                    Origin = 'https://discord.com'
                },
                Body = game:GetService("HttpService"):JSONEncode({
                    cmd = 'INVITE_BROWSER',
                    nonce = game:GetService("HttpService"):GenerateGUID(false),
                    args = {code = 'BxmnCneRRz'}
                })
            })
            Rayfield:Notify({
                Title = "Success!",
                Content = "Open your discord and verify to get the key!",
                Duration = 3.5,
                Image = "rewind",
             })
            end)
        end
    end
})
