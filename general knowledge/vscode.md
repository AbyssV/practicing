# VS Code

[TOC]

## configuration file

Inside ```.vscode``` file, change ```tasks.json``` to run tasks, change ```launch.json``` to run the debugger

Change ```settings.json``` to overwrite user settings.

Change ```keybindings.json``` to customize keyboard shortcuts.

### ```.eslintrc.json```

Install the ESLint extension. Configure your linter however you'd like. Consult the ESLint specification for details on its linting rules and options.

### ```package.json```

See IntelliSense for your ```package.json``` file.

### ```setting.jasn```

some of my settings

```json
{
	"editor.formatOnPaste": false,
    "editor.fontSize": 14,
    "terminal.integrated.shell.windows": "C:\\WINDOWS\\System32\\cmd.exe",
    "workbench.colorTheme": "Solarized Light",
    "[markdown]": {
        "editor.wordWrap": "on",
        "editor.quickSuggestions": true
    },
    "git.path": "C:\\extension\\Git\\bin.exe",
    "editor.suggestSelection": "first",
    "vsintellicode.modify.editor.suggestSelection": "automaticallyOverrodeDefaultValue",
    "python.jediEnabled": false,
    "terminal.integrated.inheritEnv": false, //I don't want to use terminal for Anaconda
    "diffEditor.renderSideBySide": false, // version control for diffs is not side by side but a inline view
}
```

check for more [customizations](https://code.visualstudio.com/docs/getstarted/settings) here

For the settings, which you only want for specific languages, you can scope the settings by the language identifier. You can find a list of commonly used language ids in the [Language Identifiers](https://code.visualstudio.com/docs/languages/identifiers) reference.

```json
"[languageid]": {

}
```



## Tips and Tricks

### Getting started

Open the **Welcome** page to get started with the basics of VS Code. **Help > Welcome**.



### Open multiple files from Quick Open

You can open multiple files from **Quick Open** by pressing the Right arrow key. This will open the currently selected file in the background and you can continue selecting files from **Quick Open**. (在同一个文件夹内)



### Change language mode

If you want to persist the new language mode for that file type, you can use the **Configure File Association for** command to associate the current file extension with an installed language.



### File associations
Create language associations for files that aren't detected correctly. For example, many configuration files with custom file extensions are actually JSON.

```json
"files.associations": {
    ".database": "json"
}
```



### Preventing dirty writes
VS Code will show you an error message when you try to save a file that cannot be saved because it has changed on disk. VS Code blocks saving the file to prevent overwriting changes that have been made outside of the editor.

In order to resolve the save conflict, click the **Compare** action in the error message to open a diff editor that will show you the contents of the file on disk (to the left) compared to the contents in VS Code (on the right):

Use the actions in the editor toolbar to resolve the save conflict. You can either **Accept** your changes and thereby overwriting any changes on disk, or **Revert** to the version on disk. Reverting means that your changes will be lost.

**Note**: The file will remain dirty and cannot be saved until you pick one of the two actions to resolve the conflict.



### Keymaps
Are you used to keyboard shortcuts from another editor? You can install a Keymap extension that brings the keyboard shortcuts from your favorite editor to VS Code. Go to **Preferences > Keymap Extensions** to see the current list on the Marketplace. 



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

You can add additional cursors to all occurrences of the current selection with ```Ctrl+Shift+L.```

>Note: You can also change the modifier to ```Ctrl/Cmd``` for applying multiple cursors with the ```editor.multiCursorModifier``` setting 

If you do not want to add all occurrences of the current selection, you can use ```Ctrl+D``` instead. This only selects the next occurrence after the one you selected so you can add selections one by one.



### Column (box) selection
You can select blocks of text by holding ```Shift+Alt``` (```Shift+Option``` on macOS) while you drag your mouse. A separate cursor will be added to the end of each selected line.



### Fast scrolling


Pressing the ```Alt``` key enables fast scrolling in the editor and Explorers. By default, fast scrolling uses a 5X speed multiplier but you can control the multiplier with the **Editor: Fast Scroll Sensitivity** (```editor.fastScrollSensitivity```) setting.



### Peek
Select a symbol then type ```Alt+F12```. Alternatively, you can use the context menu.



### Peek References
Select a symbol then type ```Shift+F12```. Alternatively, you can use the context menu.



### Find All References view
Select a symbol then type ```Shift+Alt+F12``` to open the References view showing all your file's symbols in a dedicated view.



### Rename Symbol
Select a symbol then type ```F2```. Alternatively, you can use the context menu.



### Go to Definition
Select a symbol then type ```F12```. Alternatively, you can use the context menu or ```Ctrl+click``` (```Cmd+click``` on macOS).

You can go back to your previous location with the **Go > Back** command or ```Alt+Left```.

You can also see the type definition if you press ```Ctrl``` (```Cmd``` on macOS) when when you are hovering over the type.



### Search and modify
Besides searching and replacing expressions, you can also search and reuse parts of what was matched, using regular expressions with capturing groups. Enable regular expressions in the search box by clicking the **Use Regular Expression** ```.*``` button (```Alt+R```) and then write a regular expression and use parenthesis to define groups. You can then reuse the content matched in each group by using ```$1```, ```$2```, etc. in the Replace field.



### Git integration

#### Diffs

From the **Source Control** view, select the file to diff. Default is side by side diff. 

#### Inline view

Toggle inline view by clicking the **More Actions** (...) button in the top right and selecting **Switch to Inline View**. If you prefer the inline view, you can set ```"diffEditor.renderSideBySide": false```.

#### Review pane

Navigate through diffs with ```F7``` and ```Shift+F7```. This will present them in a unified patch format. Lines can be navigated with arrow keys and pressing ```Enter``` will jump back in the diff editor and the selected line.

#### Edit pending changes

You can make edits directly in the pending changes of the diff view.

#### Branches
Easily switch between Git branches via the Status Bar.

#### Stage all

Hover over the number of files and click the plus button.

#### Stage selected

Stage a portion of a file by selecting that file (using the arrows) and then choosing **Stage Selected Ranges** from the **Command Palette**.

#### See Git output
VS Code makes it easy to see what Git commands are actually running. This is helpful when learning Git or debugging a difficult source control issue.

Use the **Toggle Output** command (```Ctrl+Shift+U```) and select **Git** in the drop-down.

#### Resolve merge conflicts
During a merge, go to the **Source Control** view (```Ctrl+Shift+G```) and make changes in the diff view.

#### Set VS Code as default merge tool

```
git config --global merge.tool code
```



### Debugging

#### Configure debugger
Open the **Command Palette** (```Ctrl+Shift+P```) and select **Debug**: Open ```launch.json```, which will prompt you to select the environment that matches your project (Node.js, Python, C++, etc). This will generate a ```launch.json``` file. Node.js support is built-in and other environments require installing the appropriate language extensions.

#### Inline values
You can set ```"debug.inlineValues": true``` to see variable values inline in the debugger. This feature can be expensive and may slow down stepping, so it is disabled by default



### Task runner

#### Auto detect tasks
Select **Terminal** from the top-level menu, run the command **Configure Tasks**, then select the type of task you'd like to run. This will generate a ```tasks.json``` file

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



### Tips

#### Run npm scripts as tasks from the explorer



#### Minimap

You can move the minimap to the left hand side or disable it completely by respectively setting ```"editor.minimap.side": "left"``` or ```"editor.minimap.enabled": false``` in your user or workspace settings.



#### Explorer

You can drag and drop files into the Explorer from outside VS Code to copy them (if the explorer is empty VS Code will open them instead)

VS Code works very well with other tools that you might use, especially command-line tools. If you want to run a command-line tool in the context of the folder you currently have open in VS Code, right-click the folder and select **Open in Command Prompt** (or **Open in Terminal** on macOS or Linux).

You can also navigate to the location of a file or folder in the native Explorer by right-clicking on a file or folder and selecting **Reveal in Explorer** (or **Reveal in Finder** on the macOS or Open Containing Folder on Linux).

Type ```Ctrl+P``` (**Quick Open**) to quickly search and open a file by its name.

By default, VS Code excludes some folders from the Explorer (for example. ```.git```). Use the ```files.exclude``` setting to configure rules for hiding files and folders from the Explorer.

> Tip: This is really useful to hide derived resources files, like ```\*.meta``` in Unity, or ```\*.js``` in a TypeScript project. For Unity to exclude the ```\*.cs.meta``` files, the pattern to choose would be: ```"**/*.cs.meta": true```. For TypeScript, you can exclude generated JavaScript for TypeScript files with: ```"**/*.js": {"when": "$(basename).ts"}```.





## Keyboard Shortcut

```ctrl+shift+p```/```cmd+shift+p```: Command Palette. Type ```?``` to view help suggestions.

```ctrl+P```: quick open

```ctrl+` ```: integrated terminal 

**```ctrl+B```**: toggle sidebar ```ctrl+K Z```: zen mode. Press ```Esc``` twice to exit Zen Mode.

```ctrl+click/cmd+click```: You can quickly open a file or image or create a new file by moving the cursor to the file link. (打开一个文件，多用于js，因为有<script src="">)

```ctrl+Tab```: Navigate entire history. Navigate back: ```Alt+Left```; Navigate forward: ```Alt+Right```

```ctrl+\```: side by side editing. You can also drag and drop editors to create new editor groups and move editors between groups.  Switch between editors: ```Ctrl+1```, ```Ctrl+2```, ```Ctrl+3```

```Shift+Alt+Up``` or ```Shift+Alt+Down```: Copy line up / down

```Alt+Up``` or ```Alt+Down```: Move line up and down

```Shift+Alt+Left``` or ```Shift+Alt+Right```: Shrink / expand selection

```Ctrl+Shift+[``` and ```Ctrl+Shift+]```: Code folding

```Ctrl+K Ctrl+X```: Trim trailing whitespace

```Ctrl+K Ctrl+F```: Code formatting. Whole document format: ```Shift+Alt+F```

```Ctrl+U```: Undo cursor position

```Ctrl+L```: Select current line

```Ctrl+G```: Navigate to a specific line

```Ctrl+Home``` and ```Ctrl+End```: Navigate to beginning and end of file

```Ctrl+Shift+O```: Go to Symbol in File. You can group the symbols by kind by adding a colon, ```@:```.

```Ctrl+T```: Go to Symbol in Workspace

```Ctrl+Shift+V```: Open Markdown preview. Use ``` Ctrl+K V``` for side by side Markdown edit and preview.

```Ctrl+Space```:  trigger the Suggestions widget by IntelliSense. 