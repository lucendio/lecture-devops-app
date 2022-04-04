Lecture: DevOps - Application
=============================


> :warning: __Invoking `make` in a path containing white spaces will break execution and may lead to
> unforeseen side effects like DATA LOSS !__


This repository contains the [application](./app/README.md) that can be used as *deployable workload* for the
[project assignment](https://github.com/lucendio/lecture-devops-material/blob/master/assignments/project-work.md)
implementation.

In order to adapt the application and integrate it into your automation and deployment processes, it's usually not
required to change any existing code. Instead, you probably just want to add some *pipeline* code or even a container
file (e.g. `Dockerfile`).


### Getting started 

For more information regarding the app, please take a look into its [README](./app/README.md).

The `Makefile` in this directory can be seen as the main entry point for this repository. It's meant to locally run the
application and allow to mess around with the source code in order to better understand how it works and to be able to
tear it apart if necessary.
Additionally, it documents various invocations that may help you adapting this application as *workload* for the
assignment. 

**_Please note, that the `Makefile` is only meant to showcase steps that are usually taken to automate the deployment
lifecycle of such an application and code base.
It is NOT recommended to invoke `make` targets from the CI/CD, but rather to utilize platform-specific interfaces 
(e.g. `.gitlab-ci.yml`, `Jenkinsfile`, etc.), which may then invoke commands shown in the `make` target or in the
`scripts` section of one of the `package.json` files._**


### Prerequisites

The following software must be installed and available in `${PATH}`:

* `node` ([NodeJS](https://nodejs.org/en/download)): latest v16
* `npm` ([npm](https://www.npmjs.com/get-npm)): latest v8
* `mongod` ([MongoDB](https://docs.mongodb.com/manual/installation/)): latest v4.4

*NOTE: the application in this repository has not been tested with versions newer than that*

Choose for yourself how you want to install these dependencies. Perhaps you can use the package manager
available on your operating system, or maybe you prefer using container images. 


### Commands

The following commands are available from the root directory:


#### `make install`

* installs all *server* and *client* dependencies via package manager `npm` 


#### `make build`

1. copy server source into some empty location
2. copy dependency manifest (`package*`) into the same location right next to the server source
3. install server dependencies there
4. install all client dependencies next to its source
5. build client code and put it next to the server source (step 1)   


#### `make test`

*NOTE: requires/assumes a MongoDB service (see `MONGODB_URL`) to be reachable from the context where tests are being
executed*

* runs client & server tests in [CI mode](https://jestjs.io/docs/en/cli.html#--ci) (exits regardless of the test outcome;
  closed tty)


#### `make dev-test-client`

*NOTE: only demonstrates a use case during local development and are not meant to run in any other context (e.g. automation)*

* runs client tests in a local development mode


#### `make dev-start-db`

*NOTE: only demonstrates a use case during local development and are not meant to run in any other context (e.g. automation)*

* starts a local MongoDB service


#### `make dev-start-app`

*NOTE (1): only demonstrates a use case during local development and are not meant to run in any other context (e.g. automation)*
*NOTE (2): it might be desired to first start a database service (e.g. `make dev-start-db`)*

* builds client
* starts server in development mode with development configuration


#### `make run`

*NOTE (1): showcases plain executable invocation with a shared parent process. Press `Ctrl+C` to send termination signal.*
*NOTE (2): in reality those two services would always be invoked independently and __never__ share a parent process!*

* starts a MongoDB service as a child process with an explicit inline-configuration
* starts the application service with variables being set in a way so that they are only *visible* to that invocation
  (as an alternative to the configuration file `app/server/dev.env` that is used to set environment variables)
* blocks terminal and keeps it as output device until termination signal is being send.


#### `make clean`

* removes all `node_modules` dependencies that have been installed locally via `npm`
* removes other temporarily created folder in `.local` 
