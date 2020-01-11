FROM alpine AS base
FROM base AS build
WORKDIR /src
RUN mkdir /app && apk add make g++ git && git clone https://github.com/ioquake/ioq3 .
COPY Makefile.local ./
RUN make && cp -R ./build/release-*/ioq3ded.* /app/ioq3ded 
FROM base AS app
MAINTAINER John Merchant <john@jmercha.dev>
WORKDIR /quake3
COPY --from=build /app/ioq3ded /usr/bin/ioq3ded 
ENTRYPOINT ["/usr/bin/ioq3ded"]
