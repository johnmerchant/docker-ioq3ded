FROM alpine AS base
FROM base AS build
WORKDIR /src
RUN mkdir /app
RUN apk add make g++ git
RUN git clone https://github.com/ioquake/ioq3 .
COPY Makefile.local ./
RUN make
RUN cp -R ./build/release-*/* /app 

FROM base AS app
WORKDIR /app
COPY --from=build /app/* ./ 
