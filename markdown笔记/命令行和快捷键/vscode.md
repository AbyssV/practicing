# VS Code

## configuration file

Inside ```.vscode``` file, change ```tasks.json``` to run tasks, change ```launch.json``` to run the debugger

Change ```settings.json```(workspace settings) to overwrite user settings.

Change ```keybindings.json``` to customize keyboard shortcuts.

### ```.eslintrc.json```

Install the [ESLint extension](https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint). Configure your linter however you'd like. Consult the [ESLint specification](https://eslint.org/docs/user-guide/configuring) for details on its linting rules and options.

关于eslint的简介[Eslint 超简单入门教程](https://www.jianshu.com/p/ad1e46faaea2)。这是一个编码规范的工具，需要npm和node环境。

For python,you can modify your own ```.pylintrc``` file to customize messages

### ```package.json```

See IntelliSense for your ```package.json``` file.

### ```setting.json```

some of my settings

```json
{
    "editor.fontSize": 16,
    "terminal.integrated.fontSize": 16,
    "terminal.integrated.fontFamily": "Lucida Console",
    "workbench.colorTheme": "Solarized Light",

    "terminal.integrated.shell.windows": "C:\\WINDOWS\\System32\\cmd.exe",
    //"terminal.integrated.shell.windows": "C:\\extension\\cygwin64\\bin\\bash.exe",
    //"terminal.integrated.shell.windows": "C:\\extension\\Git\\bin.exe",
    //"terminal.integrated.shell.windows": "C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe",
    "terminal.external.windowsExec": "C:\\extension\\Git\\bin\\bash.exe",
    "terminal.integrated.shellArgs.windows": ["/K chcp 65001 >nul"], //执行 chcp 65001 就可以把cmd的编码设置成uft-8了
    //"terminal.integrated.inheritEnv": false, //I don't want to use terminal for Anaconda

    "editor.suggestSelection": "first", //default is recentlyUsed
    "vsintellicode.modify.editor.suggestSelection": "automaticallyOverrodeDefaultValue",
    "editor.tabCompletion": "on",//这个属性是表示在出现推荐值时，按下Tab键是否自动填入最佳推荐值
    "diffEditor.renderSideBySide": false,// version control for diffs is not side by side but a inline view

    "[markdown]": {
        "editor.wordWrap": "on", //自动换行
        "editor.quickSuggestions": true //智能提示
    },

    "git.path": "C:\\extension\\Git\\bin\\bash.exe",
    
    "python.jediEnabled": false, //使用Jedi作为IntelliSense引擎（true）还是Microsoft Python语言服务器（false）
    "python.pythonPath": "C:\\software\\Anaconda3\\python.exe",    
    "python.languageServer": "Pylance",
    "[python]": {
        "editor.wordBasedSuggestions": false
    },
    "jupyter.alwaysTrustNotebooks": true,
}

{
    "editor.rulers": [20, 40, 60], //竖线
}


/*
//c++，没测试
// cygwin 的安装目录
// 使得 cygwin 切换到当前工作目录
"terminal.integrated.env.windows": {
"CHERE_INVOKING": "1"
},
// 使 cygwin 能够在 vscode 中正常使用 Shell 命令
"terminal.integrated.shellArgs.windows": [
"-l"
],
*/


```

check for more [customizations](https://code.visualstudio.com/docs/getstarted/settings) here

For the settings, which you only want for specific languages, you can scope the settings by the language identifier. You can find a list of commonly used language ids in the [Language Identifiers](https://code.visualstudio.com/docs/languages/identifiers) reference.

```json
{
  "[typescript]": {
    "editor.formatOnSave": true,
    "editor.formatOnPaste": true
  },
  "[markdown]": {
    "editor.formatOnSave": true,
    "editor.wordWrap": "on",
    "editor.renderWhitespace": "all",
    "editor.acceptSuggestionOnEnter": "off"
  }
}
```



## Tips and Tricks

### Getting started

Open the **Welcome** page to get started with the basics of VS Code. **Help > Welcome**.

### Open multiple files from Quick Open

You can open multiple files from **Quick Open**)(```ctrl+p```) by pressing the Right arrow key. This will open the currently selected file in the background and you can continue selecting files from **Quick Open**. (在同一个文件夹内)

### Preventing dirty writes
VS Code will show you an error message when you try to save a file that cannot be saved because it has changed on disk. VS Code blocks saving the file to prevent overwriting changes that have been made outside of the editor.

In order to resolve the save conflict, click the **Compare** action in the error message to open a diff editor that will show you the contents of the file on disk (to the left) compared to the contents in VS Code (on the right):

Use the actions in the editor toolbar to resolve the save conflict. You can either **Accept** your changes and thereby overwriting any changes on disk, or **Revert** to the version on disk. Reverting means that your changes will be lost.

**Note**: The file will remain dirty and cannot be saved until you pick one of the two actions to resolve the conflict.

### Customize your keyboard shortcuts

Keyboard Shortcut: ```Ctrl+K Ctrl+S```(按两次)

You can search for shortcuts and add your own keybindings to the ```keybindings.json``` file.

```json
{
	"key":"cmd+y",
	"command": "redo",
	"when":"editorTextFocus"
}
```

See more in Key Bindings for [Visual Studio Code](https://code.visualstudio.com/docs/getstarted/keybindings).

### Multi cursor selection

To add cursors at arbitrary positions, select a position with your mouse and use ```Alt+Click``` (```Option+click``` on macOS).

To set cursors above or below the current position use ```Ctrl+Alt+Up``` or ```Ctrl+Alt+Down```

```Ctrl+U```: undo last cursor operation - 很有用，不光在这里

```Alt+Shift+I```: 选中一堆文本后，按下可在每一行的末尾都创建一个光标，包括空行

>Note: You can also change the modifier to ```Ctrl/Cmd``` for applying multiple cursors with the ```editor.multiCursorModifier``` setting 

If you do not want to add all occurrences of the current selection, you can use ```Ctrl+D``` instead. This only selects the next occurrence after the one you selected so you can add selections one by one.

### Column (box) selection
You can select blocks of text by holding ```Shift+Alt``` (```Shift+Option``` on macOS) while you drag your mouse. A separate cursor will be added to the end of each selected line. 不包括空行

### Transform text commands

You can change selected text to uppercase, lowercase, and title case with the **transform** commands from the Command Palette.

### Search and modify

Besides searching and replacing expressions, you can also search and reuse parts of what was matched, using regular expressions with capturing groups. Enable regular expressions in the search box by clicking the **Use Regular Expression**``` .*``` button (```alt+R```) and then write a regular expression and use parenthesis to define groups. You can then reuse the content matched in each group by using ```$1```, ```$2```, etc. in the Replace field.

### Create custom snippets

**File** > **Preferences** > **User Snippets** (**Code** > **Preferences** > **User Snippets** on macOS), select the language, and create a snippet. See more details in [Creating your own Snippets](https://code.visualstudio.com/docs/editor/userdefinedsnippets).

应该是编码习惯自定义，这个vim也有

### 在新建文件夹的时候，如果直接输入 ```aa/bb/cc```，那么，就可以创建多层子文件夹

### Emmet in VS Code



### Git integration ```Ctrl+Shift+G```

#### Diffs

From the **Source Control** view, select the file to diff. *Default is side by side diff*. 

#### Inline view

Toggle inline view by clicking the **More Actions** (...) button in the top right and selecting **Switch to Inline View**. If you prefer the inline view, you can set ```"diffEditor.renderSideBySide": false```.

#### Review pane

Navigate through diffs with ```F7```(顺序看) and ```Shift+F7```(倒序看). This will present them in a unified patch format. Lines can be navigated with arrow keys and pressing ```Enter``` will jump back in the diff editor and the selected line.

#### Edit pending changes

You can make edits directly in the pending changes of the diff view.

#### Branches
Easily switch between Git branches via the Status Bar.(左下角)

#### Stage all

Hover over the number of files and click the plus button.(颜色会由灰**U**变为绿**A**)

#### Stage selected

Stage a portion of a file by selecting that file (using the arrows) and then choosing **Stage Selected Ranges** from the **Command Palette**.

#### Undo last commit

点右上角的**...**，再点击**Undo Last Commit**

#### See Git output
VS Code makes it easy to see what Git commands are actually running. This is helpful when learning Git or debugging a difficult source control issue.

Use the **Toggle Output** command (```Ctrl+Shift+U```) and select **Git** in the drop-down.

#### Resolve merge conflicts
During a merge, go to the **Source Control** view (```Ctrl+Shift+G```) and make changes in the diff view.

You can resolve merge conflicts with the inline CodeLens which lets you **Accept Current Change**, **Accept Incoming Change**, **Accept Both Changes**, and **Compare Changes**.

#### Set VS Code as default merge tool

```
git config --global merge.tool vscode
git config --global mergetool.vscode.cmd 'code --wait $MERGED'
```

#### Set VS Code as default diff tool

```
git config --global diff.tool vscode
git config --global difftool.vscode.cmd 'code --wait --diff $LOCAL $REMOTE'
```

### Debugging

#### Configure debugger
Open the **Command Palette** (```Ctrl+Shift+P```) and select **Debug**: Open ```launch.json```, which will prompt you to select the environment that matches your project (Node.js, Python, C++, etc). This will generate a ```launch.json``` file. Node.js support is built-in and other environments require installing the appropriate language extensions. See the debugging [documentation](https://code.visualstudio.com/docs/editor/debugging) for more details.

#### Data inspection
Inspect variables in the **Debug** panels and in the console. 

#### Inline values
You can set ```"debug.inlineValues": true``` to see variable values inline in the debugger. This feature can be expensive and may slow down stepping, so it is disabled by default

#### Logpoints

Logpoints act much like breakpoints but instead of halting the debugger when they are hit, they log a message to the console. Logpoints are especially useful for injecting logging while debugging production servers that cannot be modified or paused.

Add a logpoint with the **Add Logpoint** command in the left editor gutter and it will be displayed as a "diamond" shaped icon. Log messages are plain text but can include expressions to be evaluated within curly braces ('{}').

非阻塞，挺好用的

### Task runner

#### Auto detect tasks
Select **Terminal** from the top-level menu, run the command **Configure Tasks**, then select the type of task you'd like to run. This will generate a ```tasks.json``` file. See the [Tasks](https://code.visualstudio.com/docs/editor/tasks) documentation for more details.

There are occasionally issues with auto generation. Check out the documentation for getting things to work properly.

#### Run tasks from the Terminal menu
Select **Terminal** from the top-level menu, run the command **Run Task**, and select the task you want to run. Terminate the running task by running the command **Terminate Task**

#### Define keyboard shortcuts for tasks
You can define a keyboard shortcut for any task. From the **Command Palette** (```Ctrl+Shift+P```), select **Preferences: Open Keyboard Shortcuts File**, bind the desired shortcut to the ```workbench.action.tasks.runTask``` command, and define the Task as ```args```.

For example, to bind  ```Ctrl+H``` to the ```Run tests``` task, add the following:

```json
{
  "key": "ctrl+h",
  "command": "workbench.action.tasks.runTask",
  "args": "Run tests"
}
```

#### Run npm scripts as tasks from the explorer

From the explorer you can open a script in the editor, run it as a task, and launch it with the node debugger (when the script defines a debug option like `--inspect-brk`). The default action on click is to open the script. To run a script on a single click, set `npm.scriptExplorerAction` to "run". Use the setting `npm.exclude` to exclude scripts in `package.json` files contained in particular folders.

With the setting `npm.enableRunFromFolder`, you can enable to run npm scripts from the File Explorer's context menu for a folder. The setting enables the command **Run NPM Script in Folder...** when a folder is selected. The command shows a Quick Pick list of the npm scripts contained in this folder and you can select the script to be executed as a task.



## User Interface

### Side by side editing
You can open as many editors as you like side by side vertically and horizontally. If you already have one editor open, there are multiple ways of opening another editor to the side of the existing one:

- ```alt``` click on a file in the Explorer.
- ```ctrl+\``` to split the active editor into two.
- **Open to the Side** (```Ctrl+Enter```) from the Explorer context menu on a file.
- Click the **Split** Editor button in the upper right of an editor.
- Drag and drop a file to any side of the editor region.
- ```ctrl+Enter``` (macOS: ```cmd+Enter```) in the **Quick Open** (```Ctrl+P```) file list.

Whenever you open another file, the editor that is active will display the content of that file. So if you have two editors side by side and you want to open file 'foo.cs' into the right-hand editor, make sure that editor is active (by clicking inside it) before opening file 'foo.cs'.

By default editors will open to the right-hand side of the active one. You can change this behavior through the setting ```workbench.editor.openSideBySideDirection``` and configure to open new editors to the bottom of the active one instead.

When you have more than one editor open you can switch between them quickly by holding the ```ctrl ```(macOS: ```cmd```) key and pressing ```1```, ```2```, or ```3```.

> Tip: You can resize editors and reorder them. Drag and drop the editor title area to reposition or resize the editor.

There are a predefined set of editor layouts in the new **View** > **Editor Layout** menu

Editors that open to the side (for example by clicking the editor toolbar **Split Editor** action) will by default open to the right-hand side of the active editor. If you prefer to open editors below the active one, configure the new setting `workbench.editor.openSideBySideDirection: down`.

There are many keyboard commands for adjusting the editor layout with the keyboard alone, but if you prefer to use the mouse, drag and drop is a fast way to split the editor into any direction

> Pro Tip: If you press and hold the Alt key while hovering over the **toolbar action** to split an editor, it will offer to split to the other orientation. This is a fast way to split either to the right or to the bottom(按住```alt```的同时点右上角的标识)

### Minimap

You can click or drag the shaded area to quickly jump to different sections of your file. You can move the minimap to the left hand side or disable it completely by respectively setting ```"editor.minimap.side": "left"``` or ```"editor.minimap.enabled": false``` in your user or workspace settings.

### Breadcrumbs

The editor has a navigation bar above its contents called Breadcrumbs. It shows the current location and allows you to quickly navigate between folders, files, and symbols.

Breadcrumbs always show the file path and if the current file type has language support for symbols, the symbol path up to the cursor position. You can disable breadcrumbs with the **View > Show Breadcrumbs** toggle command. For more information about the breadcrumbs feature, such as how to customize their appearance, see the [Breadcrumbs](https://code.visualstudio.com/docs/editor/editingevolved#_breadcrumbs) section of the [Code Navigation](https://code.visualstudio.com/docs/editor/editingevolved) article.

在tab和代码之间的那一小行，似乎还挺有参考性的

### Explorer

You can drag and drop files into the Explorer from outside VS Code to copy them (if the explorer is empty VS Code will open them instead)

VS Code works very well with other tools that you might use, especially command-line tools. If you want to run a command-line tool in the context of the folder you currently have open in VS Code, right-click the folder and select **Open in Command Prompt** (or **Open in Terminal** on macOS or Linux).

You can also navigate to the location of a file or folder in the native Explorer by right-clicking on a file or folder and selecting **Reveal in Explorer** (or **Reveal in Finder** on the macOS or **Open Containing Folder** on Linux).

> Tip: Type ```Ctrl+P``` (**Quick Open**) to quickly search and open a file by its name.

By default, VS Code excludes some folders from the Explorer (for example. ```.git```). Use the ```files.exclude``` [setting](https://code.visualstudio.com/docs/getstarted/settings) to configure rules for hiding files and folders from the Explorer.

> Tip: This is really useful to hide derived resources files, like ```\*.meta``` in Unity, or ```\*.js``` in a TypeScript project. For Unity to exclude the ```\*.cs.meta``` files, the pattern to choose would be: ```"**/*.cs.meta": true```. For TypeScript, you can exclude generated JavaScript for TypeScript files with: ```"**/*.js": {"when": "$(basename).ts"}```.

### Filtering the document tree
The Outline view is a separate section in the bottom of the File Explorer. When expanded, it will show the symbol tree of the currently active editor.

The Outline view has different **Sort By** modes, optional cursor tracking, and supports the usual open gestures. It also includes an input box which finds or filters symbols as you type. Errors and warnings are also shown in the Outline view, letting you see at a glance a problem's location.

For symbols, the view relies on information computed by your installed extensions for different file types. For example, the built-in Markdown support returns the Markdown header hierarchy for a Markdown file's symbols.

There are several Outline view [settings](https://code.visualstudio.com/docs/getstarted/settings) which allow you to enable/disable icons and control the errors and warnings display (all enabled by default):

- `outline.icons` - Toggle rendering outline elements with icons.
- `outline.problems.enabled` - Show errors and warnings on outline elements.
- `outline.problems.badges` - Toggle using badges for errors and warnings.
- `outline.problems.colors` - Toggle using colors for errors and warnings.

### Window management

The `window.restoreWindows` setting tells VS Code how to restore the opened windows of your previous session. By default, VS Code will restore all windows you worked on during your previous session (setting: `all`). Change this setting to `none` to never reopen any windows and always start with an empty VS Code instance. Change it to `one` to reopen the last opened window you worked on or `folders` to only restore windows that had folders opened.



## User and Workspace Settings

VS Code provides two different scopes for settings:

- **User Settings** - Settings that apply globally to any instance of VS Code you open.
- **Workspace Settings** - Settings stored inside your workspace and only apply when the workspace is opened.

Workspace settings override user settings. Workspace settings are specific to a project and can be shared across developers on a project.

> **Note**: A VS Code "workspace" is usually just your project root folder. Workspace settings as well as [debugging](https://code.visualstudio.com/docs/editor/debugging) and [task](https://code.visualstudio.com/docs/editor/tasks) configurations are stored at the root in a `.vscode` folder. You can also have more than one root folder in a VS Code workspace through a feature called [Multi-root workspaces](https://code.visualstudio.com/docs/editor/multi-root-workspaces).

**Note**: VS Code extensions can also add their own custom settings and they will be visible under an **Extensions** section.

### Settings file location

By default VS Code shows the Settings editor, but you can still edit the underlying `settings.json` file by using the **Open Settings (JSON)** command or by changing your default settings editor with the `workbench.settings.editor` setting.

Depending on your platform, the user settings file is located here:

- **Windows** `%APPDATA%\Code\User\settings.json`
  - `C:\Users\admin\AppData\Roaming\Code\User` in my case

- **macOS** `$HOME/Library/Application Support/Code/User/settings.json`
- **Linux** `$HOME/.config/Code/User/settings.json`

The workspace settings file is located under the `.vscode` folder in your root folder.

> **Note:** In case of a [Multi-root Workspace](https://code.visualstudio.com/docs/editor/multi-root-workspaces#_settings), workspace settings are located inside the workspace configuration file.

### Language-specific editor settings

To customize your editor by language, run the global command **Preferences: Configure Language Specific Settings** (command id: `workbench.action.configureLanguageBasedSettings`) from the **Command Palette** (```Ctrl+Shift+P```) which opens the language picker. Select the language you want, which then opens your user `settings.json` with the language entry where you can add applicable settings.

If you have a file open and you want to customize the editor for this file type, click on the Language Mode in the Status Bar to the bottom-right of the VS Code window. This opens the Language Mode picker with an option **Configure 'language_name' language based settings**. Selecting this opens your user `settings.json` with the language entry where you can add applicable settings.

**Language-specific editor settings in your user settings override workspace settings.**

You can scope language-specific settings to the workspace by placing them in the workspace settings just like other settings. If you have settings defined for a language in both user and workspace scopes, then they are merged by giving precedence to the ones defined in the workspace.

You can use IntelliSense in `settings.json` to help you find allowed language-based settings. All editor settings and some non-editor settings are supported. Some languages have default language-specific settings already set, which you can review in `defaultSettings.json` opened with the **Preferences: Open Default Settings** command.

### Settings and security

Some settings allow you to specify an executable that VS Code will run to perform certain operations. For example, you can choose which shell the Integrated Terminal should use. For enhanced security, such settings can only be defined in user settings and not at workspace scope.

Here is the list of settings not supported in workspace settings:

- `git.path`
- `terminal.external.windowsExec`
- `terminal.external.osxExec`
- `terminal.external.linuxExec`

The first time you open a workspace that defines any of these settings, VS Code will warn you and subsequently always ignore the values after that.



## Keyboard Shortcut

### interface

```ctrl+shift+p```/```F1```: Command Palette. Type ```?```  into the input field to get a list of available commands you can execute from here.

```Ctrl+K S```: save all

```alt```: Pressing the ```alt``` key enables fast scrolling in the editor and Explorers. By default, fast scrolling uses a 5X speed multiplier but you can control the multiplier with the **Editor: Fast Scroll Sensitivity** (```editor.fastScrollSensitivity```) setting.

```ctrl+P```: quick open

```ctrl+` ```: integrated terminal 

```Ctrl+Shift+` ```create new terminal

```Ctrl+Shift+C```:external terminal

```Ctrl+Pagedown/Pageup```: 在已经打开的多个文件之间进行切换

```Ctrl+B```: 显示/隐藏侧边栏

```ctrl+K Z```: zen mode. Press ```Esc``` twice to exit Zen Mode. Zen mode can be toggled using View menu, Command Palette 

```ctrl+\```: side by side editing. You can also drag and drop editors to create new editor groups and move editors between groups.  Switch between editors: ```Ctrl+1```, ```Ctrl+2```, ```Ctrl+3```

```Ctrl+Shift+V```: Open Markdown preview. Use ``` Ctrl+K V``` for side by side Markdown edit and preview.

### explorer

```ctrl+Tab```: Navigate entire history. Navigate back: ```Alt+Left```; Navigate forward: ```Alt+Right```

```ctrl+click/cmd+click```: You can quickly open a file or image or create a new file by moving the cursor to the file link, alternatively, you can select a symbol then type ```F12```(go to definition). Alternatively, you can use the context menu.

- You can go back to your previous location with the **Go > Back** command or ```Alt+Left```.
- You can also see the type definition if you press ```Ctrl``` (```Cmd``` on macOS) when you are hovering over the type.

```Ctrl+K F12```:open definition to the side

以下看不懂

***

Select a symbol then type ```alt+F12```: peek(我认为是看查源码定义)

Select a symbol then type ```shift+F12```: 函数在那些地方被调用了，包括了源码的定义。在新的窗口显示

Select a symbol then type ```shift+alt+F12``` to open the References view showing all your file's symbols in a dedicated view.在新的更大的窗口显示

Select a symbol then type ```F2```: 这个函数（或变量名）出现的地方都会被修改。Alternatively, you can use the context menu.

### coding

```Ctrl+left/right```:在单词之间移动光标

```Alt+Up``` or ```Alt+Down```: Move line up and down(把这行代码上移或下移)

```Shift+Alt+Up``` or ```Shift+Alt+Down```: Copy line up / down

```Ctrl+]\[```: indent/outdent line

```Ctrl+/```: toggle line comment

```Shift+Alt+A```:toggle block comment

```Ctrl+Shift+\```: jump to matching bracket

```Ctrl+Shift+[``` and ```Ctrl+Shift+]```: Code folding(打开或是关闭里```{}```的代码，光标停留在一个大括号外即可)

```Ctrl+K Ctrl+0``` and ```Ctrl+K Ctrl+J```: fold/unfold all regions in the editor

```Ctrl+K Ctrl+/```: fold all block comments

```Shift+Alt+F```:format document(自动对齐)

```Ctrl+K Ctrl+F```: format selection

```Ctrl+K Ctrl+X```: Trim trailing whitespace(去掉多余的空格)

```Ctrl+L```: Select current line

在当前行的位置，鼠标三击，可以选中当前行；用鼠标单机文件的行号，可以选中当前行；在某个行号的位置，上下移动鼠标，可以选中多行

```Ctrl+Shift+L```:select all occurences of current selection

```Ctrl+Home``` and ```Ctrl+End```: Navigate to beginning and end of file

```Ctrl+Shift+O```: go to symbol(methods) in file. You can group the symbols by kind by adding a colon, ```@:```(React, TextField)

```Ctrl+T```: go to symbol in workspace

```Ctrl+G```: Navigate to a specific line

```F8```:go to next error or warning

```Shift+F8```:go to previous error or warning

```Ctrl+Space```: trigger the Suggestions widget by IntelliSense. 

```Ctrl+Shift+Space```: trigger parameter hints

### Search and Replace

```Ctrl+Shift+F```: 全局搜索

```Ctrl+H```: replace

```Alt+Enter```: select all occurencecs of find match



## Color Themes

### Selecting the Color Theme

1. In VS Code, open the Color Theme picker with **File** > **Preferences** > **Color Theme**. (**Code** > **Preferences** > **Color Theme** on macOS).
2. You can also use the keyboard shortcut ```Ctrl+K Ctrl+T``` to display the picker.
3. Use the cursor keys to preview the colors of the theme.
4. Select the theme you want and press Enter.

$$
f(x) = \int_{-\infty}^{\infty}\hat f(\xi)\,e^{2 \pi i \xi x} \,d\xi
$$



