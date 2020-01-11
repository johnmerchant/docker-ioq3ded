FROM alpine
WORKDIR /src
RUN mkdir /app
RUN apk add make g++ git
RUN git clone https://github.com/ioquake/ioq3 .
COPY Makefile.local ./
RUN make
RUN cp -R ./build/release-*/* /app 

FROM scratch
WORKDIR /app
COPY --from=build /app/* ./ 
