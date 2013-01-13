---
title: 'IronRuby and the Dreaded Method not found error'
date: '2013-01-12'
description: 'How to survive the IronRuby "Method not found" error'
categories: [ironruby, .net, 'method not found']
---

This post is related to this [StackOverflow question](http://stackoverflow.com/q/13392178/697862).

**UPDATE**: This is fixed in the master branch if IronLanguages repo, check the footer [note](#note).
  
Maybe you've had it, and maybe not, but if you have, then you know how horrible it is when IronRuby gives you this totally unrelated error, for no apparent reason:

To put things in context imagine you create a very basic IronRuby application, a very simple Ruby script:

````
obj = Object.new
````

And then Boom! You get something like this:

````
Method not found: 'Microsoft.Scripting.Actions.Calls.OverloadInfo[] 
Microsoft.Scripting.Actions.Calls.ReflectionOverloadInfo.CreateArray
(System.Reflection.MemberInfo[])
````

WTF is going on? It seems IronRuby 1.1.3 came with a strange bug where you can't call Object.new even though if you run ir.exe it says System::Object clearly has a .new class method:

````
IronRuby 1.1.3.0 on .NET 4.0.30319.17929
Copyright (c) Microsoft Corporation. All rights reserved.

>>> Object.methods
=> [:Equals, :ReferenceEquals, :allocate, :clr_constructor, :clr_ctor, :clr_new, :new, ...]
````
I myself don't really understand where does thig bug come from, given that IronRuby *does* find the .new() method, but I found a simple workaround:

````
class System::Object
  def initialize
  end
end

obj = Object.new
````
Run this code, and the world makes sense again. Prepend those 4 lines to any IronRuby project (including the samples) and everything will work correctly.

<a id="note"></a> **NOTE**: Although this change does fix many applications, it does not fix others, like rubygems. This Object.new bug is fixed in the most recent version of IronRuby that you can get from the [IronRuby github repo](https://github.com/IronLanguages/main/).