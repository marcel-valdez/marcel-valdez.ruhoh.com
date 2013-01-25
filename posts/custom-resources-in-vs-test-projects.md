---
title: 'Custom resources in Visual Studio Test projects'
date: '2013-01-24'
description: 'Setting up custom resources for test projects.'
categories: ['continuous integration', 'msbuild', 'visual studio', 'automated build']
---

Many times, you need custom resources for your test projects, and these resources might be needed in several test projects.  
  
Now, you could simply copy all of these resources (files) to all your projects and 'include them' in the .csproj file, but you know this would break DRY principle, which is a [good idea to abide to](http://en.wikipedia.org/wiki/Don't_repeat_yourself).  
  
Anyway, normally if you want to copy a resource to the output directory you do this:

```
  <Target Name="CopyResources" DependsOnTargets="Build">
    <Exec Command="CALL ..\my\resources\generator.bat $(OutputPath)" />
  </Target>
```
> Note: I am assuming you have a script that generates resources and then puts them on a path you give it.

When you build your solution in your computer and execute the tests with some of the major test runners, it might work, but not with all of them; and it might fail in some cloud hosted environments, like for example AppHarbor.  

The solution is simple, instead of using `$(OutputPath)`, use `$(OutDir)`, and this will work in local and hosted environments.
  
```
  <Target Name="CopyResources" DependsOnTargets="Build">
    <Exec Command="CALL ..\my\resources\generator.bat $(OutDir)" />
  </Target>
```