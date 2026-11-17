# Noozy Watcher pro Home Assistant. Java 21 na Ubuntu (glibc) - nativní SQLite z jádra Noozy má knihovny pro
# linux_arm64 i linux_x64, na Alpine (musl) by nenaběhla. Obraz si HA postaví sám (aarch64 / amd64).
ARG BUILD_FROM
FROM eclipse-temurin:21-jre

ENV LANG=C.UTF-8 \
    NOOZY_WATCHER_DATA=/data \
    NOOZY_WATCHER_PORT=8765 \
    JAVA_OPTS="-Xmx256m -XX:+UseSerialGC -Djava.awt.headless=true --enable-native-access=ALL-UNNAMED"

# Sestavená aplikace (bin/ + lib/) - připraví ji build-watcher skript z repozitáře Noozy.
COPY app /opt/noozy-watcher

CMD ["/opt/noozy-watcher/bin/noozy-watcher"]
