---
title: 'IronRuby and the Dreaded Method not found error'
date: '2013-01-12'
description: 'How to survive the IronRuby "Method not found" error'
categories: [ironruby, .net, 'method not found']
---

So you create a very basic IronRuby application, a simple Hello World:

````
puts 'Hello world!'
````

Everything is great and beautiful as you expected. Next you try something pretty straight forward, now you try the simplest thing possible, create a new object. (Or run a sample project)

````
obj = Object.new
````

And then Boom! You get something like this:
````
Method not found: 'Microsoft.Scripting.Actions.Calls.OverloadInfo[] 
Microsoft.Scripting.Actions.Calls.ReflectionOverloadInfo.CreateArray
(System.Reflection.MemberInfo[])
````

WTF is going on? It seems IronRuby 1.1.3 came with a strange bug where you can't call Object.new even though if you run ir.exe it says it clearly has a new class method:

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

Enjoy!