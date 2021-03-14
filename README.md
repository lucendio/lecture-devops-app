Lecture: DevOps - application
=============================


This repository contains the [application](./app/README.md) that should be used as *deployable workload* for the
[exercise](https://github.com/lucendio/lecture-devops-material/blob/master/assignments/exercise.md) implementation.  


### Getting started 

For more information regarding the app, please take a look into its [README](./app/README.md).

The `Makefile` in this directory can be seen as the main entry point for this repository. It's meant to locally run the
application and mess around with the source code in order to better understand how it works and to be able to tear it
apart if necessary.
Additionally, it documents various invocations that may help you adapting this application as *workload* for the exercise. 

**_Please note, that the `Makefile` is only meant to showcase steps that are usually needed to be taken in order to
automate the deployment lifecycle of such an application and code base.
It is NOT recommended to invoke `make` targets from the CI/CD, but rather to utilize platform-specific interfaces 
(e.g. `Jenkinsfile`, `.travis.yml`, etc.), which may then invoke commands shown in the `make` target or in the `scripts`
 section of one of the `package.json` files._**


### Prerequisites

The following software must be installed and available in your `${PATH}`:

* `node` ([NodeJS](https://nodejs.org/en/download)) 
* `npm` ([npm](https://www.npmjs.com/get-npm))
* `mongod` ([MongoDB](https://docs.mongodb.com/manual/installation/))

*NOTE: [required versions](https://github.com/lucendio/lecture-devops-app/blob/master/hack/Makefile#L18-L20)*


#### Option 1

Choose for yourself how you want to install these dependencies. Perhaps you can use the package manager
available on your operating system, or maybe you prefer using container images. 


#### Option 2

Install all executables via `Makefile` into this project structure.

a) from the root directory:
```sh
make deps
```

b) from the `./hack` folder:
```sh
$(cd ./hack && make install)
```

__Don't forget to add the new folder (`./.local/bin` ) to your `${PATH}` variable in your shell environment:__ 
```sh
export PATH=$(pwd)/.local/bin:${PATH}
```


### Commands

The following commands are available from the root directory:


#### `make install`

* installs all dependencies via `npm` for *server* and *client*


#### `make build`

* builds the client code
* copies it over into the server


#### `make test`

*NOTE: requires a MongoDB service to already run (see `MONGODB_URL` in target on where it's assumed to be running)*

* runs client & server tests in [CI mode](https://jestjs.io/docs/en/cli.html#--ci) (exits regardless of the test outcome; closed tty)


#### `make dev-test-client`

*NOTE: only demonstrates a use case during local development and are not meant to run in any other context (e.g. automation)*

* runs client tests in a local development mode


#### `make dev-start-db`

*NOTE: only demonstrates a use case during local development and are not meant to run in any other context (e.g. automation)*

* starts a local MongoDB service


#### `make dev-start-app`

*NOTE (1): only demonstrates a use case during local development and are not meant to run in any other context (e.g. automation)*
*NOTE (2): it might be desired to first start a database service (e.g. `make dev-start-db`)*

* builds client (see `make build`) 
* starts server in development mode and with development configuration


#### `make run`

*NOTE (1): showcases plain executable invocation with a shared parent process. Press `Ctrl+C` to send termination signal.*
*NOTE (2): in reality those two services would always be invoked independently and __never__ share a parent process!*

* starts a MongoDB service as a child process with an explicit inline-configuration
* starts the application service with variables being set in a way so that they are only *visible* to that invocation
  (as an alternative to the configuration file `app/server/dev.env` that is used to set environment variables)
* blocks terminal and keeps it as output device until termination signal is being send.


#### `make clean`

* removes all `node_modules` dependencies that have been installed locally via `npm`


#### `make deps`

* installs the software prerequisites as prebuild binaries locally in `.local/bin`


#### `make nuke`

* removes all `npm` dependencies (see `make clean`)
* throws away `.local` folder and thus all software prerequisites that were installed within it
