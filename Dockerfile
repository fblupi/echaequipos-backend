FROM ruby:3.0.2

WORKDIR /echaequipos-backend
COPY . /echaequipos-backend
RUN bundle install

CMD ["rails", "server", "-b", "0.0.0.0"]
