### pipenv

#### Installing Pipenv
Pipenv is a dependency manager for Python projects.
Use pip to install Pipenv: ```pip install --user pipenv```

> Note This does a user installation to prevent breaking any system-wide packages. 
> If **pipenv** isn’t available in your shell after installation, you’ll need to add the user base’s binary directory to your **PATH**. 

#### Installing packages for your project
run ```cd myproject``` ```pipenv install requests``` Pipenv will install the Requests library and create a Pipfile for you in your project’s directory. The Pipfile is used to track which dependencies your project needs in case you need to re-install them, **such as when you share your project with others.** 

#### Using installed packages
Now that Requests is installed you can create a simple main.py file to use it:
```python
import requests
response = requests.get('https://httpbin.org/ip')
print('Your IP is {0}'.format(response.json()['origin']))
```
Then you can run this script using pipenv run: ```pipenv run python main.py``` You should get output similar to this: ```Your IP is 8.8.8.8``` 

#### create a virtual environment

```
python3 -m venv tutorial_env
source tutorial_env/bin/activate
```
This will create a new virtual environment in the **tutorial_env** subdirectory, and configure the current shell to use it as the **default python environment**.



### installing default packages

#### Ensure pip, setuptools, and wheel are up to date

While **pip** alone is sufficient to install from pre-built binary archives, up to date copies of the **setuptools** and **wheel** projects are useful to ensure you can also install from source archives: ```python -m pip install --upgrade pip setuptools wheel```
> Python “Virtual Environments” allow Python packages to be installed **in an isolated location** for a particular application, rather than being installed globally. 
> Imagine you have an application that needs version 1 of LibFoo, but another application requires version 2. How can you use both these applications? If you install everything into /usr/lib/python3.6/site-packages (or whatever your platform’s standard location is), it’s easy to end up in a situation where you unintentionally upgrade an application that shouldn’t be upgraded.
> Or more generally, what if you want to install an application and leave it be? If an application works, any change in its libraries or the versions of those libraries can break the application.
> Also, what if you can’t install packages into the global site-packages directory? For instance, on a shared host.
> In all these cases, virtual environments can help you. They have their own installation directories and they don’t share libraries with other virtual environments.

Currently, there are two common tools for creating Python virtual environments:

- **venv** is available by default in Python 3.3 and later, and installs pip and setuptools into created virtual environments in Python 3.4 and later.
- **virtualenv** needs to be installed separately, but supports Python 2.7+ and Python 3.3+, and pip, setuptools and wheel are always installed into created virtual environments by default (regardless of Python version).

The basic usage is like so:

**Using virtualenv:**

```
virtualenv <DIR>
source <DIR>/bin/activate
```
**Using venv:**

```
python3 -m venv <DIR>
source <DIR>/bin/activate
```
>In both of the above cases, **Windows users should not use the ```source``` command, but should rather run the activate script directly from the command shell.** The use of source under Unix shells ensures that the virtual environment’s variables are set within the current shell, and not in a subprocess (which then disappears, having no useful effect).

#### Use pip for Installing
pip is the recommended installer. The most common usage of pip is to install from the Python Package Index using a requirement specifier. Generally speaking, a requirement specifier is composed of a project name followed by an optional version specifier. PEP 440 contains a full specification of the currently supported specifiers. Below are some examples.

To install the latest version of “SomeProject”: ```pip install "SomeProject"```

To install a specific version: ```pip install "SomeProject==1.4"```

To install greater than or equal to one version and less than another: ```pip install "SomeProject>=1,<2"```

To install a version that’s “compatible” with a certain version: ```pip install "SomeProject~=1.4.2"```

*In this case, this means to install any version “==1.4.*” version that’s also “>=1.4.2”.*

#### Upgrading packages

Upgrade an already installed SomeProject to the latest from PyPI: ```pip install --upgrade SomeProject```

#### Requirements files
Install a list of requirements specified in a Requirements File: ```pip install -r requirements.txt```

For more information, check [python documentation](https://packaging.python.org/tutorials/installing-packages/#installing-packages)