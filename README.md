# Subject-Library
Useful Codes For GDScript

![Static Badge](https://img.shields.io/badge/SLib-Subject_Library-t)
![GitHub License](https://img.shields.io/github/license/subject-team/slib)
![GitHub commit activity](https://img.shields.io/github/commit-activity/t/subject-team/slib)
![GitHub Release](https://img.shields.io/github/v/release/subject-team/slib)
![GitHub commits since latest release](https://img.shields.io/github/commits-since/subject-team/slib/latest?sort=date)
![GitHub Created At](https://img.shields.io/github/created-at/subject-team/slib)
![GitHub last commit](https://img.shields.io/github/last-commit/subject-team/slib)
![GitHub Release Date](https://img.shields.io/github/release-date/subject-team/slib)
![GitHub top language](https://img.shields.io/github/languages/top/subject-team/slib)
![GitHub Issues or Pull Requests](https://img.shields.io/github/issues/subject-team/slib)
![GitHub Issues or Pull Requests](https://img.shields.io/github/issues-pr/subject-team/slib)
![Website](https://img.shields.io/website?url=https%3A%2F%2Fsubject-team.github.io%2FSLib%2F)
![GitHub Discussions](https://img.shields.io/github/discussions/subject-team/slib)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/subject-team/slib?label=code%20size%20just)
![GitHub repo size](https://img.shields.io/github/repo-size/subject-team/slib)
![GitHub forks](https://img.shields.io/github/forks/subject-team/slib?style=flat)
![GitHub Repo stars](https://img.shields.io/github/stars/subject-team/slib?style=flat)
<!--
![GitHub contributors](https://img.shields.io/github/contributors-anon/subject-team/slib)
![GitHub code search count](https://img.shields.io/github/search?query=SLib%20language%3AGDScript&label=Search%20on%20github)
![GitHub branch check runs](https://img.shields.io/github/check-runs/subject-team/slib/Main)
![GitHub Downloads (all assets, all releases)](https://img.shields.io/github/downloads/subject-team/slib/total)
![GitHub Sponsors](https://img.shields.io/github/sponsors/subject-team)
![GitHub Issues or Pull Requests](https://img.shields.io/github/issues-closed/subject-team/slib)
![GitHub Issues or Pull Requests](https://img.shields.io/github/issues-pr-closed/subject-team/slib)
![GitHub watchers](https://img.shields.io/github/watchers/subject-team/slib?style=flat)
-->

## The fastest answer to the question "What is SLib?"
SLib is a versatile library whose functions are used in any project, SLib improves code quality several times, increases its readability, prevents errors, and thus makes your project better and faster than before! The following code is just one of the things that SLib does:

### With SLib:
```gdscript
# This one line of code creates a backup of the player's data file with an optional
# extension next to it, it has the ability to check all types of errors and manage them,
# prevent syntax errors, repeating lines and code length.
SLib.backup_file("user://main_data.json")
```

### Without SLib:
```gdscript
# These 10 lines of code do the same thing as one line above, with the difference that
# the file extension and path must be specified in several places each time. 
# and creates variables that are no longer usable!
var file_access := FileAccess.open("user://main_data.json", FileAccess.READ)
var json_string := file_access.get_line()
file_access.close()
var json := JSON.new()
json.parse(json_string)
var data = json.data
var backup_json_string := JSON.stringify(data)
var backup_file_access := FileAccess.open("user://main_data.json".get_basename() + "-Backup." +"user://main_data.json".get_extension(), FileAccess.WRITE)
backup_file_access.store_var(backup_json_string)
backup_file_access.close()
```

## [Overview](https://github.com/Subject-Team/SLib#overview)
SLib is a Godot library designed to simplify and enhance your development experience. It provides a set of ready-to-use, standard codes that eliminate the need to write repetitive and lengthy scripts. SLib is lightweight, easy to install, and helps make your code more readable and maintainable.

## [Fast Getting Started](https://github.com/Subject-Team/SLib/wiki#fast-getting-started) & [Defalut Getting Started](https://github.com/Subject-Team/SLib/wiki#default-getting-started)

## Click on the desired topic:

### [Fast Getting Started](https://github.com/Subject-Team/SLib/wiki#fast-getting-started)
Let's Install!

### [Why use?](https://github.com/Subject-Team/SLib/wiki/Why-use%3F)
How does SLib help you?

### [Key Features](https://github.com/Subject-Team/SLib/wiki/Key-Features)
Why is SLib a powerful and useful library?

### [Versions](https://github.com/Subject-Team/SLib/wiki/Versions)
Browse available versions

### [Change Logs](https://github.com/Subject-Team/SLib/wiki/Change-Logs)
View the project development process

### [Supported Versions](https://github.com/Subject-Team/SLib/wiki/Supported-Versions)
In which version of Godot can I use SLib?

### [How To Install](https://github.com/Subject-Team/SLib/wiki/Installation-guid)
Install SLib on your project

### [Automation](https://github.com/Subject-Team/SLib/wiki/Automation)
Convert simple texts into complex codes

### [How To Use](https://github.com/Subject-Team/SLib/wiki/Learn-how-to-use-SLib)
Upgrade your code with SLib

### [Detailed capabilities](https://github.com/Subject-Team/SLib/wiki/Detailed-capabilities)
Learn the details of SLib's capabilities

### [Bug fix guid](https://github.com/Subject-Team/SLib/wiki/Bug-fix-guide)
How to correct errors?

### [Community and Support](https://github.com/Subject-Team/SLib/wiki/Community-and-Support)
Join the SLib community and get help from each other

### [Documentation](https://github.com/Subject-Team/SLib/wiki/Documentation)
Documentation and user guide

### [Contribute](https://github.com/Subject-Team/SLib/wiki/Types-of-contributions)
This is an open source project, we grow together!

### [Thanks](https://github.com/Subject-Team/SLib/wiki/Thanks)
Project participation process and contributors

---

### Feel free to ask questions, give ideas, and contribute in discussions and issues! 