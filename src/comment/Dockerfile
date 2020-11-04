FROM ruby:2.5-alpine

WORKDIR /app
COPY . ./

RUN apk --no-cache --update add build-base=0.5-r2 && \
    bundle install && \
    apk del build-base

ENV COMMENT_DATABASE_HOST comment_db
ENV COMMENT_DATABASE comments

CMD ["puma"]
