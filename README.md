
# rbx-types
A [EmmyLua style annotations](https://github.com/sumneko/lua-language-server/wiki/Annotations) generator for the Roblox [Engine API Reference](https://create.roblox.com/docs/reference/engine) created in Lua. Pre-generated annotations can be found [here](https://github.com/alphafantomu/rbx-types/releases/).

## Usage Help
Before running rbx-types, make sure:
- In the `rbx-types` directory using `cd` or OS equivalent command
- Proper dependencies and requirements are met for the project

To run rbx-types, run the command in your terminal: `luvit .`, a folder named `rbxannotations` will be created with all the annotation files you need.
You might need to do some manual adjustments of the annotations as rbx-types only reformats the API data into EmmyLua style annotations.

A folder named `FOLDER_NAME` (default: rbxannotations) cannot be in the same directory when running the program, it will error if it is detected.

## Installation
This rbx-types runs on [luvit](https://luvit.io/), written and tested in a Ubuntu 18.04 Virtual Machine.
It should be noted that the project no longer requires [LuaRocks](https://luarocks.org/) and it's dependencies as of `v0.0.2`. But instructions will still be below for that version, additionally you can run the project in a Windows OS as of versions beyond `v0.0.2`.

### Binaries
You will need some binaries before proceeding to use rbx-types, which are:
- [luvit](https://luvit.io/)

Sections for each of these are found below, which are just commands to help you get through it. After running the commands per section, it is expected you return to your original directory.

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
- [`WrapLayerAutoSkin`](https://create.roblox.com/docs/reference/engine/enums/WrapLayerAutoSkin)

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
