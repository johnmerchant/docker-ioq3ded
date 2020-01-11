FROM alpine AS base
FROM base AS build
WORKDIR /src
RUN mkdir /app && apk add make g++ git && git clone https://github.com/ioquake/ioq3 .
COPY Makefile.local ./
RUN make && cp -R ./build/release-*/ioq3ded.* /app/ioq3ded 
FROM base AS app
WORKDIR /app
COPY --from=build /app/ioq3ded 
ENTRYPOINT ["/app/ioq3ded"]
