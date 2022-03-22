FROM node:12
ENV ENV $ENV
ENV MONGODB_URL "mongodb://mongo_prod:27017/todo-app"
ENV CLIENT "localhost:80"
ENV PORT "3000"

WORKDIR /lecture-devops-app
COPY . .
WORKDIR /lecture-devops-app/app/client
RUN npm cache clean --force
RUN rm -rf node_modules
RUN npm install
RUN npm run build
RUN mv build /lecture-devops-app/app/server/src/public
WORKDIR /lecture-devops-app/app/server
RUN npm cache clean --force
# RUN rm -rf node_modules
RUN npm install 
EXPOSE 3000

RUN npm install env-cmd

# CMD [ "/bin/sh", "-c" , "npm run ${ENV}-start" ]
# CMD [ "/bin/sh", "-c" , "npm run start" ]
CMD ["npm", "run", "start"]
