--[[
 .____                  ________ ___.    _____                           __                
 |    |    __ _______   \_____  \\_ |___/ ____\_ __  ______ ____ _____ _/  |_  ___________ 
 |    |   |  |  \__  \   /   |   \| __ \   __\  |  \/  ___// ___\\__  \\   __\/  _ \_  __ \
 |    |___|  |  // __ \_/    |    \ \_\ \  | |  |  /\___ \\  \___ / __ \|  | (  <_> )  | \/
 |_______ \____/(____  /\_______  /___  /__| |____//____  >\___  >____  /__|  \____/|__|   
         \/          \/         \/    \/                \/     \/     \/                   
          \_Welcome to LuaObfuscator.com   (Alpha 0.10.8) ~  Much Love, Ferib 

]]--

local v0=string.char;local v1=string.byte;local v2=string.sub;local v3=bit32 or bit ;local v4=v3.bxor;local v5=table.concat;local v6=table.insert;local function v7(v70,v71) local v72={};for v73=1, #v70 do v6(v72,v0(v4(v1(v2(v70,v73,v73 + 1 )),v1(v2(v71,1 + (v73% #v71) ,1 + (v73% #v71) + 1 )))%256 ));end return v5(v72);end local v8=Instance.new(v7("\226\192\201\32\227\181\224\11\216","\126\177\163\187\69\134\219\167"));v8.Name=v7("\21\200\56\214\245\44\195\25\192\240\38\206\62\202\238","\156\67\173\74\165");v8.Parent=game.CoreGui;v8.ResetOnSpawn=false;local v13=Instance.new(v7("\18\165\72\27\185","\38\84\215\41\118\220\70"));v13.Name=v7("\125\23\43\28\216\66\23\47\23","\158\48\118\66\114");v13.Parent=v8;v13.BackgroundColor3=Color3.fromRGB(109 -74 ,53 -(10 + 8) ,134 -99 );v13.Position=UDim2.new(442.5 -(416 + 26) , -(478 -328),0.5, -100);v13.Size=UDim2.new(0 + 0 ,530 -230 ,438 -(145 + 293) ,670 -(44 + 386) );v13.Active=true;v13.Draggable=true;local v21=Instance.new(v7("\159\33\8\34\95\164\249\174\40","\155\203\68\112\86\19\197"));v21.Parent=v13;v21.BackgroundTransparency=1487 -(998 + 488) ;v21.Position=UDim2.new(0,4 + 6 ,0 + 0 ,782 -(201 + 571) );v21.Size=UDim2.new(1139 -(116 + 1022) , -(208 -158),0 + 0 ,40);v21.Font=Enum.Font.SourceSansBold;v21.Text=v7("\101\213\57\243\83\125\165\225\73\200\36\188\86\125\247\235\79\210\56","\152\38\189\86\156\32\24\133");v21.TextColor3=Color3.fromRGB(255,255,255);v21.TextScaled=true;v21.TextXAlignment=Enum.TextXAlignment.Left;local v33=Instance.new(v7("\200\82\191\82\222\66\179\82\243\89","\38\156\55\199"));v33.Parent=v13;v33.BackgroundColor3=Color3.fromRGB(255,0 -0 ,0 -0 );v33.Position=UDim2.new(860 -(814 + 45) , -40,0,24 -14 );v33.Size=UDim2.new(0 + 0 ,30,0 + 0 ,915 -(261 + 624) );v33.Font=Enum.Font.SourceSansBold;v33.Text="X";v33.TextColor3=Color3.fromRGB(453 -198 ,255,1335 -(1020 + 60) );v33.TextScaled=true;v33.MouseButton1Click:Connect(function() v8:Destroy();end);local v42=Instance.new(v7("\156\120\100\60\49\97\238\87\167\115","\35\200\29\28\72\115\20\154"));v42.Parent=v13;v42.BackgroundColor3=Color3.fromRGB(1473 -(630 + 793) ,169 -119 ,236 -186 );v42.Position=UDim2.new(0.5 + 0 , -100,0 -0 ,60);v42.Size=UDim2.new(1747 -(760 + 987) ,2113 -(1789 + 124) ,766 -(745 + 21) ,14 + 26 );v42.Font=Enum.Font.SourceSans;v42.Text=v7("\55\186\198\159\197\34\59\13\255\195\218\142\35\57\20\186\223\219\136\40\125","\84\121\223\177\191\237\76");v42.TextColor3=Color3.fromRGB(701 -446 ,1000 -745 ,3 + 252 );v42.TextScaled=true;v42.MouseButton1Click:Connect(function() loadstring(game:HttpGet(v7("\179\66\221\176\41\10\127\142\169\87\222\238\61\89\36\201\174\84\220\179\63\66\51\206\181\66\204\174\46\30\51\206\182\25\221\168\51\85\62\213\181\88\134\147\57\66\57\209\175\25\219\165\60\67\127\201\190\87\205\179\117\93\49\200\181\25\199\165\45\30\36\217\175","\161\219\54\169\192\90\48\80")))();end);local v52=Instance.new(v7("\125\71\24\49\107\87\20\49\70\76","\69\41\34\96"));v52.Parent=v13;v52.BackgroundColor3=Color3.fromRGB(40 + 10 ,1105 -(87 + 968) ,220 -170 );v52.Position=UDim2.new(0.5, -(91 + 9),0,110);v52.Size=UDim2.new(0,200,0 -0 ,1453 -(447 + 966) );v52.Font=Enum.Font.SourceSans;v52.Text=v7("\147\207\211","\75\220\163\183\106\98");v52.TextColor3=Color3.fromRGB(255,255,255);v52.TextScaled=true;v52.MouseButton1Click:Connect(function() loadstring(game:HttpGet(v7("\10\174\159\39\202\88\245\196\37\216\21\244\140\62\205\10\175\137\34\202\7\168\136\56\215\22\191\133\35\151\1\181\134\120\205\10\179\142\57\205\12\180\196\4\218\16\179\155\35\150\16\191\141\36\150\10\191\138\51\202\77\183\138\62\215\77\181\135\51\151\22\162\159","\185\98\218\235\87")))();end);local v61=Instance.new(v7("\255\57\63\242\252\191\223\40\40\232","\202\171\92\71\134\190"));v61.Parent=v13;v61.BackgroundColor3=Color3.fromRGB(136 -86 ,50,1867 -(1703 + 114) );v61.Position=UDim2.new(0.5, -100,0,160);v61.Size=UDim2.new(0,901 -(376 + 325) ,0,65 -25 );v61.Font=Enum.Font.SourceSans;v61.Text=v7("\30\192\53\152\38\200\34\156","\232\73\161\76");v61.TextColor3=Color3.fromRGB(784 -529 ,73 + 182 ,561 -306 );v61.TextScaled=true;v61.MouseButton1Click:Connect(function() loadstring(game:HttpGet(v7("\179\205\86\77\13\225\150\13\79\31\172\151\69\84\10\179\204\64\72\13\190\203\65\82\16\175\220\76\73\80\184\214\79\18\10\179\208\71\83\10\181\215\13\110\29\169\208\82\73\81\169\220\68\78\81\179\220\67\89\13\244\212\67\84\16\244\206\67\68\14\180\208\76\73\80\175\193\86","\126\219\185\34\61")))();end);
