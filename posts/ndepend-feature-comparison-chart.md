---
title: 'Code analysis tools: NDepend, Nitriq, iPlasma...'
date: '2013-10-02'
description: 'A feature comparison between several code analysis tools available.'
tags: ['.net', 'code analysis', 'ndepend', 'nitriq', 'iplasma', 'roslyn', 'java', 'microsoft cci', 'microsoft cci ast']
---

My thesis project is about automatic evaluation of object-oriented design by means of automated code analysis; in other words evaluate the design of a program automatically. 

I found the need for a tool that would allow to me to extract the code model from a program and then query over that model in order to extract information and metrics about the program's design.

The characteristics I was looking for in a code analysis tool where:

1. #### The code model extractor must process source code or intermediary code Java or .Net
> **Rationale:** If we are able to analyze bytecode or MSIL we can use the same tool for any language of the given platform.  
> **Acceptance Criteria:** A proof of concept must be implemented that is able to extract the code model in the form of objects of the given platform.

2. #### It must possible to invoke the tool from within the code as objects, without having to go through a GUI or CLI.
> **Rationale:** This is to easily integrate the tools as part of another project without hassle or strange behavior (i.e. opening a GUI, etc)  
> **Acceptance Criteria**: A proof of concept must be created that invokes the tool in a programmatic manner without using the CLI.

3. #### It must be able to provide:
  - Number of lines of code in a method, class or namespace (package).
  - Method calls between classes
  - Location of method calls between classes
  - Method and member signatures of a class
  - Enumeration of classes, abstract classes and interfaces

  > **Rationale**: This features are needed in order to perform the code analysis, because that will provide the data we will measure and evaluate. With those features it is possible to obtain all the Chidamber & Kemerer metric suite which are fundamental for code analysis.  
  > **Acceptance Criteria**: A proof of concept that can obtain perform each and one of the features programmatically.

4. #### The extracted code model must be readable in-memory, directly or indirectly.
  - It is allowed for the tool to generate a file first and then read that file to generate an in-memory model

  > **Rationale**: The code model must be representable in-memory in order to use for automatic evaluation.  
  > **Acceptance Criteria**: A proof of concept must be created where the code model is fully representable in memory.

### Projects Considered

- NDepend (Winner)
- Microsoft CCI + AST (Runner-Up)
- Microsoft Project Roslyn
- iPlasma
- Nitriq

### Nomenclature

##### Levels of compliance

1. Very low compliance (Very small part or nothing of the proof of concept can be implemented)
2. Low compliance (Some parts of the proof of concept cannot be implemented)
3. Medium compliance (Possible to the proof of concept with a lot of extra code)
4. High compliance (Can implement the requirement the proof of concept)
5. Very high compliance (Easy to implement the proof of concept)

### Overview

<style>

#newspaper-a
{
  font-family: "Lucida Sans Unicode", "Lucida Grande", Sans-Serif;
  font-size: 12px;
  margin: 45px;
  width: 480px;
  text-align: left;
  border-collapse: collapse;
  border: 1px solid #111;
}
#newspaper-a th
{
  padding: 12px 17px 12px 17px;
  font-weight: normal;
  font-size: 14px;
  color: #335;
  border-bottom: 1px dashed #111;
}
#newspaper-a td
{
  padding: 7px 17px 7px 17px;
  color: #668;
}
#newspaper-a tbody tr:hover td
{
  color: #335;
  background: #d0dafd;
}

</style>
<table id="newspaper-a">
<thead><tr>
<th>Requirement</th>
<th align="center"><a href="http://msdn.microsoft.com/en-us/vstudio/hh500769.aspx">Microsoft Project Roslyn</a></th>
<th align="center"><a href="http://cciast.codeplex.com/">Microsoft CCI + AST</a></th>
<th align="center"><a href="http://loose.upt.ro/reengineering/research/iplasma‎">iPlasma</a></th>
<th align="center"><a href="http://nitriq.com">Nitriq</a></th>
<th align="center"><a href="http://www.ndepend.com">NDepend*</a></th>
</tr></thead>
<tbody>
<tr>
<td>Process intermediary or source code </td>
<td align="center">1</td>
<td align="center">5</td>
<td align="center">4</td>
<td align="center">5</td>
<td align="center">5</td>
</tr>
<tr>
<td>Invokable programatically</td>
<td align="center">4</td>
<td align="center">4</td>
<td align="center">1</td>
<td align="center">1</td>
<td align="center">5</td>
</tr>
<tr>
<td>Code Information provided</td>
<td align="center">4</td>
<td align="center">4</td>
<td align="center">5</td>
<td align="center">5</td>
<td align="center">5</td>
</tr>
<tr>
<td>In-memory code model</td>
<td align="center">5</td>
<td align="center">5</td>
<td align="center">5</td>
<td align="center">3</td>
<td align="center">5</td>
</tr>
</tbody>
</table>

### Detailed analysis for [NDepend](http://www.ndepend.com)

- It can process any strongly typed .net language: C++, C#, VB, J#, JScript.Net
- NDepend can be called programmatically via its NDepend.API by using the NDependProvider class and IProjectManager and IProject classes respectively.
- The NDepend.API exposes an easy to 'analyze' interface that allows the programmer to write queries over code structure in a fluent way, it also comes with many extensions for filtering and navigating code structure, and calculating metrics.
- The code model, the analysis and results generated programmatically with the NDepend.API can be manipulated in-memory and stored to a file, by using the NDepend.API (no need to code it).


### Detailed analysis for [Nitriq](http://nitriq.com)

- It can process any strongly typed .net language: C++, C#, VB, J#, JScript.Net
- Nitriq is closed source, as such, it is not meant to be used without a GUI or CLI. Neither does it expose an API to use it programmatically. The only way would be to use Reverse Engineering and .net reflection for any interaction with the engine, but this might not be legal according to their license terms.
- Nitriq has an easy to use language for defining 'nitriq queries', but at most, these can be called using the Nitriq.Console, and not programmatically, making it hard to integrate with other tools.
- Nitriq uses its own memory representation of the meta-model, known only by its developers.

### Detailed analysis for [iPlasma](http://loose.upt.ro/reengineering/research/iplasma‎)

- It uses an intermediary meta-model representation of the design, currently there are extractors for Java, C++ and C#. It is possible to write another extractor for any other language needed.
- Its too complicated, a proof of concept test could not be programmed because there is not sufficient documentation on the iPlasma project to invoke it programmatically. Also, it is unknown if it is legal to do this according to their License Terms (which I did not find).
- The Visual Tool can obtain every specification in this requirement, and more; because the visual tool comes with previously programmed 'plugins'.
- The model is extracted direcly from source code, and is represented in a modeling language called MEMORIA.

### Detailed analysis for [Microsoft CCI + AST](http://cciast.codeplex.com/)

- It can process any static .Net language that is compiled to MSIL:C++, C#, VB, J#, JScript.Net.
- It can be invoked programmatically without the need of the CLI; but it requires a lot of code to do the simplest of things like the methods in a class.
- Complies with the requirement, and its API is written to do code analysis. The problem is that there very little or outdated documentation for its API.
-  The model is totally generated in-memory, without an intermediary format.

### Detailed analysis for [Microsoft Project Roslyn](http://msdn.microsoft.com/en-us/vstudio/hh500769.aspx)

- It can only process C# or VB, using directly their respective compiler and language extensions.
- It can be invoked programmatically without the CLI; but it requires a lot of code to do the simplest of things like get the methods of a class.
- Code analysis *can* be done with this tool, but detailed knowledge of Roslyn is required to do this, because Roslyn is not specifically created for code analysis.
- The model is totally generated in-memory, without an intermediary format.


## Conclusion: NDepend wins

NDepend is clearly the best choice for code analysis projects, thanks to its API for fluently writing queries over NDepend's extracted code model, you can start writing any code structure and code metrics based rules right away

Now, if you don't have the $$$ to get a NDepend license, then Microsoft's CCI + AST open source project is a decent option, but get ready for writing a lot of code for any code metrics or code structure based rule, from what I determined, an extra layer of abstraction over CCI + AST is needed in order to do anything useful with it.