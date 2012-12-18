---
title: "Introducing Dependency Locator"
date: '2012-12-18'
description: "Dependency Locator is an implementation of the Service Locator pattern with a twist."
categories: ['software design', programming]
tags: [modularity, design, IoC]
---
[](#what-is-dependency-locator)What is Dependency Locator?
----------------------------------------------------------

Dependency Locator is an implementation of the Service Locator pattern
with a twist (aren't they all?). Dependency Locator uses a C\# API for
setting up dependencies (no more hundreds of XML configuration for your
dependencies).

[](#features)Features
---------------------

-   Fluent C\# API for Dependency configuration
-   It can setup Singletons
-   It can setup Configuration values
-   It can setup Lazy evaluated Dependencies, Singletons or
    Configuration values
-   It can setup Named dependencies
-   It understands generic interfaces and implementations

[](#what-are-its-advantages)What are its advantages?
----------------------------------------------------

-   Almost no XML configuration (the example given here is your
    template, you just have to change 1 line)
-   Uninvasive changes necessary to refactor out dependencies
-   Can be used for integration testing, by setting up a combination of
    dummy and real implementations under test
-   Promotes the use of modularity in the system structure
-   Its perfect for refactoring legacy code
-   Its perfect for making legacy code more testable

[](#where-can-i-find-it)Where can I find it?
--------------------------------------------

You can find it at Github,
[HERE](http://github.com/marcel-valdez/dependency-locator "Git repository for Dependency Locator")

[](#story-of-example-usage)Story of Example Usage
-------------------------------------------------

*Note*: Removed all usings and code that is not pertinent to this
example. Let's say John has an application where you have a View, Model
and Controller as such:

    /* The Account Controller */
    namespace Bank.Controllers {
        using Bank.Models;

        public class AccountController : Controller {
            private readonly DataContext db = new DataContext();

            public ActionResult Details(int id) {
                Accounts account = db.Accounts.Find(id);

                if (account == null) {
                    return HttpNotFound();
                }

                return View(account);
            }

            /* Rest of the code... */
        }
    }

    /* The Account Details view*/
    @model Bank.Model

    @{
        ViewBag.Title = "My balance";
    }

    <h2>Account Details</h2>

    <p>
        @Html.LabelFor(model => model.AccountHolder, "Account Holder: ");
        @Html.LabelFor(model => model.AccountNumber, "Account Number: ");
        @Html.LabelFor(model => model.Balance, "Balance: ");
    </p>

    /* The Account model */
    namespace Bank.Models {
        public class Account {
            public string AccountHolder { get; set; }

            public decimal Balance { get; private set; }

            public int AccountNumber { get; set; }

            public void Deposit(decimal money) {
                if (money <= 0) throw new  Exception("Can't deposit less than or equal to $0.00");
                this.Balance += money;
            }

            public void Withdraw(decimal money) {
                if (money <= 0) throw new  Exception("Can't withdraw less than or equal to $0.00");
                this.Balance -= money;
            }
        }
    }

You may have noticed that the View could call at any point in time:

    model.Deposit(9999);
    or
    model.Withdraw(9999);

The View has no need and should not use any of these methods. It is a
mistake for it to have access to those methods, and should not be
visible to the view. So Dave notices this design smell, and wants to add
a ViewModel, so the View uses a reduced interface of the Model, but he
doesn't want to move around any of the model code because he is too lazy
(which is good!) to modify someone else's code. 
  
But his Boss tells the team: The size of the ASP.NET MVC website project is getting too big and unwieldly, from now on, any new classes that aren't Views, Models or Controllers  must be placed in separate C\# library projects. 
  
So Dave creates a new C\# Library project called Bank.ViewModels and adds the following ViewModel:

    namespace Bank.ViewModels {
        using Bank.Models;

        public class AccountDetailsViewModel {
            public AccountDetailsViewModel(Account account) {
                this.AccountHolder = account.AccountHolder;
                this.AccountNumber = account.AccountNumber;
                this.Balance = account.Balance;
            }

            public string AccountHolder { get; private set; }

            public int AccountNumber { get; private set; }

            public decimal Balance { get; private set; }
        }
    }

Dave procedes to add a reference to the ASP.Net MVC Website Project
because there is where the model is, but when he tries to add a
reference from the ASP.Net MVC Website project to the Bank.ViewModels,
catastrophe happens!  

He cannot because a circular dependency would
occur:  
`Bank.ViewModels depends on --> -- Bank depends on -->
Bank.ViewModels`
  
Aha! But Dave is a smart guy and he knows that in these
cases he has to use the Inversion of Control principle, so he creates
ANOTHER project, that will contain the public interfaces of the
ViewModels project. So he goes ahead and creates a new C\# library
project called Bank.ViewModel.Interfaces:

    namespace Bank.ViewModels.Interfaces {
        public interface IAccountDetailsViewModel {
            string AccountHolder { get; }
            int AccountNumber { get; }
            decimal Balance { get; }
        }
    }

Dave also procedes to change the definition of the
AccountDetailsViewModel:

    namespace Bank.ViewModels {
        using Bank.Models;
        using Bank.ViewModels.Interfaces;

        public class AccountDetailsViewModel: IAccountDetailsViewModel {
            /* Rest of the code */
        }
    }

So now, all Dave has to do is add a dependency on the ASP.Net Website to
the Bank.ViewModels.Interfaces library, and change the View so it uses
the ViewModel interface, and not the concrete implementation:

    @model Bank.ViewModels.Interfaces.IAccountDetailsViewModel

    @{
        ViewBag.Title = "My balance";
    }

    <h2>Account Details</h2>

    <p>
        @Html.LabelFor(model => model.AccountHolder, "Account Holder: ");
        @Html.LabelFor(model => model.AccountNumber, "Account Number: ");
        @Html.LabelFor(model => model.Balance, "Balance: ");
    </p>

Now, the controller has to provide the View with the *interface* of the
ViewModel, but as we know, one cannot just "instantiate" an interface,
it needs to call the constructor, *here* is where *DependencyLocator*
comes into play. In order for Dave to setup this dependency, all he has
to do are 2 things:

-   In the Bank.ViewModels project he has to add a new class for setting
    up the dependencies it provides as such:

<!-- -->

    namespace Bank.ViewModels {
        using DependencyLocation;
        using DependencyLocation.Setup;
        using Bank.ViewModels.Intefaces;

        public class Setup : IDependencySetup {

            public void SetupDependencies(IDependencyConfigurator container, string prefix, string defaultKey) {
                container.SetupDependency<IAccountDetailsViewModel, AccountDetailsViewModel>(defaultKey);
            }
        }
    }

-   He has to tell the Dependency Locator it has to load that Setup
    class in the Bank.ViewModels project. This is done by creating a
    dependency.config file and calling the Dependency Loader during
    startup in the Global.asax file.

##### Contents of dependency.config:

    <?xml version="1.0" encoding="utf-8" ?>
    <configuration>
      <configSections>
        <sectionGroup name="dependencyInjector">
          <section
            name="dependencyConfiguration"
            type="DependencyLocation.Configuration.DependencyConfiguration, DependencyLocator, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null"
            allowLocation="true"
            allowDefinition="Everywhere"
          />
        </sectionGroup>
      </configSections>

      <dependencyInjector>
        <dependencyConfiguration defaultKey="default">
          <dependencies>
            <add assemblyName="Bank.ViewModels, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null" namedInstancePrefix="" />
          </dependencies>
        </dependencyConfiguration>
      </dependencyInjector>
    </configuration>

The assembly where the dependencies are setup doesn't necessarily have
to be the same one where the concrete implementations are provided. The
assembly that sets up dependencies could be separate from interfaces and
implementations. 
  
The setup Assembly could be in charge of setting up N
interface libraries with M implementation libraries. In such a case, the
setup assembly would need references to all the interface and
implementation libraries it sets up. The
DependencyLoader will load any and all IDependencySetup implementors
configured in the dependency.config file.
  
##### Global.asax.cs contents:

    namespace Bank {
        public class BankMvcApplication : System.Web.HttpApplication {
            protected void Application_Start() {
                    DependencyLoader.Loader.LoadDependencies("dependency.config");

                    /* Rest of the Application_Start code */
            }

            /* Rest of the Global.asax.cs file */
        }
    }

Finally, Dave modifies the Controller code to return a ViewModel instead
of a Model:

    namespace Bank.Controllers
    {
        using Bank.ViewModels.Interfaces;
        using Bank.Models;
        using DependencyLocation;

        public class AccountController : Controller {
            private readonly DataContext db = new DataContext();

            public ActionResult Details(int id) {
                Accounts account = db.Accounts.Find(id);

                if (account == null) {
                    return HttpNotFound();
                }

                /* 
     * This will call the constructor for the concrete type setup for IAccountDetailsViewModel interface.
     * Notice however, that it could just as well be a dummy implementation of the interface, useful for testing purposes.
     */
                return View(Dependency.Locator.Create<IAccountDetailsViewModel>(account));
            }

            /* Rest of the code... */
        }
    }

Taddah! Now Dave has refactored the system to use IoC:

  * Without altering existing project structure
  * Without modifying much of the original code, notice we just: 
    - Modified 2 lines of executable code
    - Added 1 new line in Global.asax
    - Added 3 using statements. 
  * That's the main advantage of DependencyLocator, it is not invasive at all, so its very useful for refactoring legacy code.
