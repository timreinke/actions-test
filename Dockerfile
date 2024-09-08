FROM ruby:3.2

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN apt update && apt install -y strace

RUN gem install bundler:2.5.11
RUN bundle install


COPY . .

CMD ["strace", "-f", "-e", "trace=!all", "bundle", "exec", "rake", "demo"]