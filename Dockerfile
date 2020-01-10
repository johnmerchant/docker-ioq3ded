FROM --platform=$BUILDPLATFORM alpine AS base

FROM base AS build

WORKDIR /src

RUN mkdir /app

RUN apk add git make g++
RUN git clone https://github.com/ioquake/ioq3.git /src

COPY Makefile.local ./

RUN make
RUN cp -R ./build/release-*/* /app 

FROM base AS app
WORKDIR /app
COPY --from=build /app/* ./ 
