Todo-App
========


This application represents the *deployable workload* for the
[lecture assignment](https://github.com/lucendio/lecture-devops-material/blob/master/assignments/exercise.md). 

The application consists of two parts:

* frontend (`./client`)
* backend (`./server`)

During the build process, the client code is moved into the `./public` directory within the server source code.
Aside from providing an HTTP API, the backend also functions as a static file server for the client. As a result,
backend and frontend are both bundled into a single artifact (see `make build` as an example).

If you want to build each part separately:

```bash
cd ./client
npm install
npm run build

cd ./../server
npm install --prod

cd ./../
cp ./client/public ./server/public
cp ./server ${TARGET_RUNTIME_LOCATION}
```

The following technologies have been utilized (aka. MERN-stack):

* React (rendering engine of the web-based graphical user interface)
* Express (web-server framework)
* Node (Javascript runtime in the backend)
* MongoDB (persistence layer)

Other, most noticeable dependencies are:

* [Jest](https://jestjs.io/) as the test framework for both parts
* [Webpack](https://webpack.js.org/) to bundle the frontend
* [Babel](https://babeljs.io/) to transpile and therewith support latest Ecmascript versions
* [ESLint](https://eslint.org/) to ensure code quality (linting); is invoked as part of the webpack build chain 
* [Mongoose](https://mongoosejs.com/docs/api.html) as the database driver


##### Full disclosure

This application was forked from [Aamir Pinger](https://github.com/aamirpinger)'s [ToDo app][https://github.com/aamirpinger/todo-app-client-server-kubernetes]
