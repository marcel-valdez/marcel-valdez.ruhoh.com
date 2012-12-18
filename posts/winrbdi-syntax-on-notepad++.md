---
title: "WinRBDI Syntax on Notepad++"
date: '2012-12-18'
description:
categories: [notepad++, syntax, programming, academic]
---

In this small guide, you will be guided in the steps to add Syntax
Highlighting and Auto-Complete features for WinRDBI Relational Algebra
for Notepad++.
  
**Step 1:** Create a new file called userDefineLang.xml
in `%APPDATA%\Notepad++\`, and add to it the content of this
[gist](https://gist.github.com/3764935#file_user_define_lang.xml).

**Step2:** Create a new file called winrdbi.xml in
`%PROGRAMFILES%\Notepad++\plugins\APIs\`, and add to it the content of
this [gist](https://gist.github.com/3764935#file_winrdbi.xml).

**Step3:** If your background is white, the highlighting will look ugly,
for that you need a dark theme for notepad, in order to activate a theme
compatible with this Syntax Highlighter, you’ll have to create a file
called `Obsidian_mod.xml` in `%PROGRAMFILES%\Notepad++\themes\`, and add
to it the content of this
[gist](https://gist.github.com/3764935#file_obsidian_mod.xml).
  
Then enable Obsidian\_mod in Notepad++: Settings -\> Style Configurator -\>
Select theme: Obsidian\_Mod 
  
**Result:**

![]({{urls.media}}/winrdbi_syntax_auto1.png)
