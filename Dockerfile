FROM ruby:3.2.2

# Install Node.js and basic dependencies
RUN apt-get update -qq && apt-get install -y \
    nodejs \
    wget \
    unzip \
    libnss3 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libdrm2 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    libgbm1 \
    libasound2 \
    fonts-liberation \
    libu2f-udev \
    x11-apps

# Install Google Chrome
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update -qq && apt-get install -y google-chrome-stable

WORKDIR /app

# Copy Gemfile and install dependencies
COPY Gemfile Gemfile.lock ./
RUN gem install bundler -v 2.3.26
RUN bundle install

# Copy application code
COPY . .

# Precompile assets
RUN bundle exec rake assets:precompile

# Expose port 3000 for the Rails server
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
