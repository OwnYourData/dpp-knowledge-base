FROM ruby:3.3-slim AS site
WORKDIR /src
RUN apt-get update && apt-get install -y --no-install-recommends build-essential && rm -rf /var/lib/apt/lists/*
COPY Gemfile Gemfile.lock ./
RUN bundle config set --local without development && bundle install
COPY . .
RUN JEKYLL_ENV=production bundle exec jekyll build

FROM node:22-slim AS search
WORKDIR /src
COPY --from=site /src/_site ./_site
RUN npx -y pagefind@1.3.0 --site _site

FROM nginx:1.27-alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=search /src/_site /usr/share/nginx/html/kb
EXPOSE 8080
