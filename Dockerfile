FROM alpine:3.7

RUN \
apk --no-cache --update add \
  tar \
  gzip \
  py-pip \
  python \
  mysql-client \
  unzip \
  curl \
&& pip install --upgrade \
  pip \
  awscli \
&& apk del py-pip \
&& curl -O https://downloads.rclone.org/rclone-current-linux-amd64.zip \
&& unzip rclone-current-linux-amd64.zip \
&& cd rclone-*-linux-amd64 \
&& cp rclone /usr/bin/ \
&& chown root:root /usr/bin/rclone \
&& chmod 755 /usr/bin/rclone \
&& cd .. \
&& rm -rf rclone-*-linux-amd64 \
&& rm -f /var/cache/apk/*

ADD backup /
ADD restore /

CMD ["./backup"]
