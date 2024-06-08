# Stage 1: Build the release
FROM elixir:1.14.1-alpine AS build

# Install Hex + Rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Set environment
ENV MIX_ENV=prod

# Install dependencies
WORKDIR /app
COPY mix.exs mix.lock ./
COPY config config
RUN mix deps.get --only $MIX_ENV
RUN mix deps.compile

# Copy the rest of the application
COPY . .

# Build the release
RUN mix release

# Stage 2: Prepare the release image
FROM alpine:3.14

RUN apk add --no-cache bash openssl ncurses-libs
WORKDIR /app

# Copy the release from the build stage
COPY --from=build /app/_build/prod/rel/phoenix_service ./

# Expose the port that the Phoenix app runs on
EXPOSE 4000

# Command to run the Phoenix application
CMD ["bin/phoenix_service", "start"]
