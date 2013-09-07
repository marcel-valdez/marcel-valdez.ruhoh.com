---
title: "Extreme Programming in the Real World"
date: '2013-09-07'
description: "Remdinder that Values and Principles guide Practices"
categories: ['extreme programming', 'software development']
---

This post is primarily to remind me of the concepts behind Extreme Programming. This post will help me remember that Extreme Programming is not just pair programming, TDD, reduced documentation, evolutionary design and reduced planning.

XP practices are actually the *smallest* piece in the puzzle, the guiding values and principles are what made Kent Beck come up with those practices.

(Human) Values **=>** (Domain Specific) Principles **=>** (Software Specific) Practices

### Values of Extreme Programming

Values are intended to balance and support each other. Improving communication helps achieve simplicity by eliminating unneeded or deferrable requirements from today's concerns.

Values do not provide concrete advice about what to do in software development. Because of the distance between values and practices, for that *Principles* bridge the gap between them.

- **Communication**
  - Communication is important for creating a sense of team and effective cooperation.
  - The objective of communication is to transfer knowledge and information between the team(s).
- **Simplicity**
  - Simplicity is the most intensely intellectual of the XP values. 
  - The objectives are to make a system simple enough to gracefully solve only today's problem and eliminate the waste of unnecessary complexity. 
  - It is also important to remember that simplicity is contextual, the design must be understandable by the team working on it, otherwise it is pointless.
- **Feedback**
  - Change is inevitable in software development, therefore an XP team embraces change by giving high value to feedback.
  - XP teams strive to generate as much feedback as they can handle as quickly as possible.
  - They try to shorten the feedback cycle to minutes or hours instead of weeks or months. The sooner you know, the sooner you can **adapt**.
- **Courage**
  - Courage is effective action in the face of fear.
  - Doing something without regard for the consequences is **not** effective teamwork.
  - Courage alone is dangerous, in concert with other values it is powerful.
  - Examples: The courage to speak truths, to discard failing solutions and to seek new ones.
- **Respect**
  - The other four values point to one that lies below the surface: respect.
  - The contributions of each person on the team need to be respected. I am important and so are you.
  - Every person whose life is touched by software development has equal values as a human being.
- **Others**
  - Your organization, your team, and you yourself may choose other values. What is most important is aligning team behavior to team values.


### Principles of Extreme Programming

Principles are a set of domain-specific (in this case, software development) guidelines for finding practices in harmony with XP's values.

Understanding the principles gives you the opportunity to create practices that work in harmony with your existing practices and your overall goals.

- **Humanity**
  - Acknowledge human needs, frailty, and leverage human strength.
  - Acting like software is not written by people exacts a high cost on participants. This is not good for business, with the costs and disruption of high turnover and missed opportunities for creative action.
- **Economics**
  - Time value of money (a dollar now is worth more than a dollar later). Software is more valuable if it earns money now and spends money later, but not so late that it spends more money than what it earned.
  - Option value of systems and teams (a system that is flexible enough to do more than its current concrete function is more valuable)
  - The balance between the building a flexible system and building it early keeps these two in check.
- **Mutual Benefit**
  - This is the most important and difficult principle.
  - Every activity should benefit all concerned.
  - Example: I write automated tests that benefit me now and future programmers as well.
  - Counter Example: I write extensive documentation that does *not* benefit me now, but benefits an unknown person later *if* documentation is up-to-date.
  - Example: I refactor to remove accidental complexity to achieve
    - Giving me both satisfactions and fewer defects
    - Making the code easier to understand for those who encounter it later
    - Produce features faster in the short and medium term future.
- **Self-Similarity**
  - Try copying the structure of one solution into a new context, even at different scales.
  - This applies to work flows, design patterns and architecture styles.
  - Examples are using writing user stories first for epics, then writing test cases first for user stories, and then write automated tests and work your way up. The pattern of test-first can be applied at all levels of abstraction (self-similarity).
- **Improvement**
  - In software development *perfect* is a verb, not an adjective. No process, design or story is perfect. You can, however, perfect your process, design and stories.
  - Excellence is achieved by means of continuous improvement.
  - *Find a reasonable starting place, get started and improve from there*.
- **Diversity**
  - Teams need to bring together a variety of **skills, attitudes, and perspectives to see problems and pitfalls**, to think in multiple ways to solve problems, and to implement the solutions.
  - Good Conflict is an opportunity, not a problem, as long as the team resolves it productively.
  - Diversity is expressed in the practice of *Whole Team*, where you bring together on the team people with a variety of skills and perspectives.
- **Reflection**
  - Good teams thinks think about *how* they are working and *why* they are working. 
  - Good teams analyze why they succeeded or failed; they don't try to hide their mistakes, but expose them and actively learn from them.
  - Reflection are observations on a team's **actions**. Learning is action reflected. To maximize feedback, reflection in XP teams is mixed with doing.
  - Reflection is the Observation and Conclusion phases of the Scientific Method. One cannot reflect without an empiric experiment (a team's actions).
- **Flow**
  - Flow is delivering a sustainable stream of valuable software by engaging in all activities of development simultaneously.
  - The practices of XP are biased towards a continuous flow of activities rather than discrete phases.
  - Strive to deliver value as frequently as possible in all phases of software development.
- **Opportunity**
  - Problems are symptoms that something needs to change. Do not take the attitude of "survival" and fix just enough to 'get by'. To reach excellence, problems need to turn into opportunities for learning and improvement, not just survival.
  - This principle helps maximize strengths and minimize weaknesses.
  - Conciously choose to transform each problem into an opportunity: an opportunity for personal growth, deepening relationships, and improved software.
  - This principle applies to an individual, a team, a department and an entire organization.
  - An individual is not delivering in small chunks? Fine, have him reflect how to *deliver* a feature in small chunks and ask a more experienced developer to review the breakdown.
- **Redundancy**
  - The critical, difficult problems in software development should be solved in several different ways; that way, even if one solution fails utterly, the other solutions will prevent *disaster*.
  - Example: Defects are a critical and difficult problem and they are addressed by many XP Practices: pair programming, continuous integration, sitting together, real costumer involvement, daily deployment, and TDD. These practices are certainly redundant, catching some of the same defects.
  - You cannot solve a complex and critical problem with a single practice, instead you follow redundant practices to reduce or resolve it.
- **Failure**
  - If you are having trouble succeeding, fail. Failure is not a waste if it imparts knowledge. Knowledge is valuable and sometimes hard to come by, sometimes it requires failure.
  - Do the cheapest thing that can gain you knowledge about the problem you don't know how to solve yet.
  - Time is time is time. Do not waste a couple of weeks discussing, when you could have wasted a couple days programming and have the same insight.
- **Quality**
  - Sacrificing quality is not effective as a means of control. Quality is not a control variable.
  - Projects do not go faster by accepting lower quality. They do not go slower by demanding higher quality.
  - Pushing quality higher often results in faster delivery; while lowering quality standards often results in later, less predictable delivery.
  - XP chooses scope as the primary means of planning, tracking, and steering projects. The weekly and quarterly cycles provide explicit points for tracking and choosing scope, not as scriptures set in stone.
- **Baby Steps**
  - What is the least you could do that is recognizably in the right direction?
  - Individuals and teams can make many small steps so rapidly that they appear to be leaping.
  - The overhead of small steps is much less than when a team wastefully recoils from aborted big changes.
- **Accepted Responsibility**
  - Responsibility canno be assigned; it can only be embraced, by teams and individuals.
  - With responsibility comes authority. Misalignments distort the team's communication.
  - Example: When a process expert can tell me how to work, but does not share in that work or its consequences, authority and responsibility are misaligned.

### *Primary* Practices of Extreme Programming

The practices are a vector from where you are to where you can be with XP. In XP, you make a progress towards this ideal state of effective development. For example, daily deployment may make no sense if you only deploy once a year. Successfully deploying more frequently is an improvement, building confidence for the next step.

The XP practices do not represent some kind of pinnacle in the evolution of software development. They are a common way station on the road to improvement. Taken one at a time you will see improvement. When they begin to compound you may see dramatic improvement. The interactions between the practices amplify their effect.

- **Sit Together**
  - Develop in an open space big enough for the whole team. Meet the need for privacy and *owned* space by having small private spaces nearby or by limiting work hours so team members can get their privacy needs met elsewhere.
  - No matter what the organization/department/team says the problem is, it is always a people problem. Technical fixes alone are not enough.
  - It is extremelly important to communicate with all our senses.
- **Whole Team**
- **Informative Workspace**
- **Energized Work**
- **Pair Programming**
- **Stories**
- **Weekly Cycle**
- **Quarterly Cycle**
- **Slack**
- **Ten-Minute Build**
- **Continuous Integration**
- **Test-First Programming**
- **Incremental Design**

## *Corollary* Practices of Extreme Programming
- Real Customer Involvement
- Incremental Deployment
- Team Continuity
- Shrinking Teams
- Root-Cause Analysis
- Shared Code
- Code and Tests
- Single Code Base
- Daily Deployment
- Negotiated Scope Contract
- Pay-Per-Use