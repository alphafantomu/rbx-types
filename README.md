
# rbx-types
A EmmyLua style annotations generator for the Roblox [Engine API Reference](https://create.roblox.com/docs/reference/engine) created in Lua. Pre-generated annotations can be found [here](https://github.com/alphafantomu/rbx-types/releases/). As of `v0.0.2`, [LuaRocks](https://luarocks.org/) is no longer used as a package manager for the project, and can be run on Windows. This project is designed to provide code annotations in Lua with the Roblox API. 

## Usage Help
Before running rbx-types, make sure:
- In the `rbx-types` directory using `cd` or OS equivalent command
- Proper dependencies and requirements are met for the project

To run rbx-types, run the command in your terminal: `luvit .`, a folder named `rbxannotations` will be created with all the annotation files you need.
You might need to do some manual adjustments of the annotations as rbx-types only reformats the API data into EmmyLua style annotations.

A folder named `FOLDER_NAME` (default: rbxannotations) cannot be in the same directory when running the program, it will error if it is detected.

## Configuration
### Basic Configuration
There is no configuration file. You will find your needed configurations at the top of [init.lua](/init.lua).
You can configure these variables to adjust the generation process:
- `PARSER_LOCAL_LIMIT` (default: 200): the lua interpreter's local variable limit in a single file, if your interpeter can handle more then you may edit this to reduce the number of files created
- `PRELOAD_FILE_SIZE` (default: 500000): SumNeko's Lua Language Server `PRELOAD_FILE_SIZE` found in your extension settings, in settings the value is specified in `KB` kilobytes, `PRELOAD_FILE_SIZE` is specified in bytes.
- `FOLDER_NAME` (default: rbxannotations): The name of the annotations folder, since there is a limit to how many variables a single Lua file can have and it's size, multiple files are created
- `disable_lua_globals` (default: true): Determines if the documentation for [`LuaGlobals`](https://create.roblox.com/docs/reference/engine/globals/LuaGlobals) should be generated, these are already included in standard Lua interpreters, so it is a good idea to keep this, the default value.
### Advanced Configuration
This kind of configuration is there only if you are running a modified version of the Lua interpreter, you may want to look into this if:
- Interpreter has new keywords that are not included in standard Lua installations
- Lua Language Server supports unique types that arent: `nil, any, boolean, string, number, integer, function, table, thread, userdata, lightuserdata`
- API Reference has a new function that returns a unique class based on a parameter, such as `Instance.new` and `ServiceProvider.GetService`.

You will find your needed configurations at the top of [docs.lua](/docs.lua)
You can configure these variables to adjust the generation process:
- `keywords`: this is a dictionary with Lua keywords as indexes, with values preferably being 0. `next = 0;`
- `defined_types`: this is a dictionary with your EmmyLua style interpreter supplied types, this currently follows the types: `nil, any, boolean, string, number, integer, function, table, thread, userdata, lightuserdata`, additional information can be found [here](https://github.com/sumneko/lua-language-server/wiki/EmmyLua-Annotations#types-and-type).
- `requires_generic`: helps determine what parameters should be of the generic class type, this is a dictionary that specifies the index as the class name and the value as a dictionary of method/function names with values of 0. `Instance = {new = 0;}`
- `requires_optional`: helps determine what parameters should be optional, this is a dictionary that specifies the index as the class name and the value as a dictionary of method/function names with values of 0. `Instance = {new = {parent = 0;};}`

## Installation
This rbx-types runs on [luvit](https://luvit.io/), written and tested in a Ubuntu 18.04 Virtual Machine.
It should be noted that the project no longer requires [LuaRocks](https://luarocks.org/) and it's dependencies as of `v0.0.2`. But instructions will still be below for that version, additionally you can run the project in a Windows OS as of versions beyond `v0.0.2`.

### Binaries
You will need some binaries before proceeding to use rbx-types, which are:
- [luvit](https://luvit.io/)
- Lua 5.1.5 (v0.0.1)
- [LuaRocks](https://luarocks.org/) (v0.0.1)

Sections for each of these are found below, which are just commands to help you get through it. After running the commands per section, it is expected you return to your original directory.

#### Lua 5.1.5 (v0.0.1)
Run the commands below, after installation, run `lua` and you should be able to access the Lua 5.1.5 interpreter.
```bash
sudo curl -R -O http://www.lua.org/ftp/lua-5.1.5.tar.gz
sudo tar -zxf lua-5.1.5.tar.gz
cd lua-5.1.5
sudo make linux test
sudo make install
cd ~
```

#### LuaRocks 3.9.0 (v0.0.1)
Run the commands below, after installation, run `luarocks` and you should be able to access the list of luarocks commands.
If you already have a LuaRocks installation, a system-wide installation is expected
```bash
sudo wget https://luarocks.org/releases/luarocks-3.9.0.tar.gz
sudo tar zxpf luarocks-3.9.0.tar.gz
cd luarocks-3.9.0
./configure --with-lua-include=/usr/local/include
sudo make install
cd ~
```

#### Luvit
```bash
curl -L https://github.com/luvit/lit/raw/master/get-lit.sh | sh
```
Luvit has a LuaJIT interpreter but is not reliant on the Lua 5.1.5 that you installed earlier, as that was for LuaRocks.
Upon installation, your current directory will have the following binaries:
- `lit`
- `luvit`
- `luvi`

`lit` is our required package manager and `luvit` is our Lua interpreter, `luvi` helps create self-contained binaries but it won't be used here.
If not done so already, please move `lit`, `luvit` and `luvi` to your binaries folder in Ubuntu, by default it is located at `/usr/local/bin`. If you are on Windows, the `PATH` should also point to a folder for your binaries.

#### git
`sudo apt install git`

### Project Folder
After installing the required binaries, please clone this repository by running the following command or copying manually:
```bash
git clone --recursive https://github.com/alphafantomu/rbx-types.git
```
Change your directory to `rbx-types` by using `cd`.

### Dependencies
rbx-type requires dependencies from both `lit` and `LuaRocks` (v0.0.1), which are found here:
- LuaRocks (v0.0.1):
  - [lua-resty-jit-uuid](https://luarocks.org/modules/thibaultcha/lua-resty-jit-uuid)
  - [lua-gumbo](https://github.com/craigbarnes/lua-gumbo)
- Lit:
  - [coro-http](https://github.com/luvit/lit/blob/master/deps/coro-http.lua)
  - [secure-socket](https://github.com/luvit/lit/tree/master/deps/secure-socket)

For LuaRocks, you will want to run the following commands if you are running rbx-types `v0.0.1`:
```bash
luarocks install lua-resty-jit-uuid
luarocks install gumbo
```

For Lit dependencies, the required libraries are already supplied, but if you do not have the dependencies, you will want to run the following commands:
```bash
lit install creationix/coro-http
lit install luvit/secure-socket
```

### Running rbx-types
Make sure there is not a folder named `rbxannotations` in your current directory, then run `sudo luvit .` in `v0.0.1` or `luvit .` is `v0.0.2` and the generation process will begin.
If you are having to run rbx-types multiple times, this command to remove `rbxannotations` will prove useful:

```bash
sudo rm -r rbxannotations
```

### Output
After the generating is complete, you will want to move your `rbxannotations` folder to the workspace that you're developing with the Roblox API on. 

## Important Note
The EmmyLua style that rbx-types uses is tested with [SumNeko's Lua Language Server](https://github.com/sumneko/lua-language-server), you may use any EmmyLua style intellisense but somethings may not be supported. The following things are not added to the annotations from the API reference:
- Math Operation Annotations

The API Engine reference has a bunch of consistencies, I have tried to account for all of them but here are some that may cause you problems:
- Parameter names that have bad Lua syntax for variable names will remove bad characters for syntax, such as dashes or parenthesis
- Generics are used for unique class annotations, but they do not have restrictions on the generics themselves, they have restrictions on specific classnames however. Constructor/method Generics are used in these cases:
  - `Instance.new`
  - `Instance.FindFirstAncestorOfClass`
  - `Instance.FindFirstChildOfClass`
  - `Instance.FindFirstAncestorWhichIsA`
  - `Instance.FindFirstChildWhichIsA`
  - `ServiceProvider.FindService`
  - `ServiceProvider.getService`
  - `ServiceProvider.service`
  - `ServiceProvider.GetService`
- `RotationCurveKey` is an undocumented datatype that is only mentioned in [RotationCurve](https://create.roblox.com/docs/reference/engine/classes/RotationCurve), it is assumed to be a `table`.
- If the API reference page for the class is not properly formatted, then rbx-types will also suffer from it, feel free to adjust annotations as you see fit. As an example, this is from [`Players.Chatted`](https://create.roblox.com/docs/reference/engine/classes/Players#PlayerChatted):
![Players.Chatted](https://i.imgur.com/ArLsjvq.png)

The following pages are explicitly generated despite not being in the [reference list](https://create.roblox.com/docs/reference/engine):
- [`SelectionBehavior`](https://create.roblox.com/docs/reference/engine/enums/SelectionBehavior)
- [`PropertyStatus`](https://create.roblox.com/docs/reference/engine/enums/PropertyStatus)
- ['WrapLayerAutoSkin'](https://create.roblox.com/docs/reference/engine/enums/WrapLayerAutoSkin)

Any other annotation has to be specified using `---@type CLASSNAME` before it, where `CLASSNAME` is the class you want to attach the annotations of to a variable.
An example:
```lua
---@type Part
local Part = game:GetService('Workspace'):FindFirstChild('Baseplate');
```

rbx-types has been tested on `Ubuntu 18.04` on [WSL 2](https://docs.microsoft.com/en-us/windows/wsl/install#upgrade-version-from-wsl-1-to-wsl-2).

## License
[MIT License](/LICENSE)

## Contact
- Discord: `Arivistraliavatoriar#2678`