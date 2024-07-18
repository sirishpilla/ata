FROM docker-artifactory.spectrumflow.net/docker/node:16.15.0 as build

ARG ARTIFACTORY_EMAIL
ARG ARTIFACTORY_API_KEY
ARG ARTIFACTORY_PASSWORD
ARG ENV

RUN apt update && apt install -y unzip
RUN mkdir /app
RUN curl -u ${ARTIFACTORY_EMAIL}:${ARTIFACTORY_API_KEY} https://artifactory.spectrumtoolbox.com/artifactory/generic-local/articulate.zip --output articulate.zip
WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH

COPY package.json ./
COPY package-lock.json ./

# Configuration for Artifactory
RUN npm config set @kite:registry https://artifactory.spectrumtoolbox.com/artifactory/api/npm/npm/
# RUN curl --fail -u ${ARTIFACTORY_EMAIL}:${ARTIFACTORY_API_KEY} https://artifactory.spectrumtoolbox.com/artifactory/api/npm/auth >> ~/.npmrc
RUN npm set //artifactory.spectrumtoolbox.com/artifactory/api/npm/npm/:username $ARTIFACTORY_EMAIL
RUN npm set //artifactory.spectrumtoolbox.com/artifactory/api/npm/npm/:_password $ARTIFACTORY_PASSWORD
RUN npm set always-auth true
RUN npm set strict-ssl false
RUN npm set email $ARTIFACTORY_EMAIL
RUN echo ~/.npmrc

RUN npm install
COPY . ./
# RUN sh generate-dotenv-dev.sh > .env
RUN if [ "$ENV" = "production" ] ; then sh generate-dotenv-uat.sh > .env ; else sh generate-dotenv-dev.sh > .env ; fi

#RUN npm run build:dev
RUN if [ "$ENV" = "production" ] ; then npm run build:production ; else npm run build:dev ; fi

WORKDIR /app/dist
RUN unzip /articulate.zip

FROM docker-artifactory.spectrumflow.net/docker/nginx:1.19.1
COPY --from=build /app/dist /usr/share/nginx/html
COPY nginx/default.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"] 