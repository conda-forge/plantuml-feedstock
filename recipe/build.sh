#!/usr/bin/env bash
set -eux

export MAVEN_OPTS="-Xmx1G"

gradle tasks --all

gradle clean build pdfJar -x test

ls -lathr build/libs

cp build/libs/plantuml-pdf-*.jar "${PREFIX}/lib/plantuml.jar"

echo '#!/bin/bash' > $PREFIX/bin/plantuml
echo 'java -Xmx500M -jar "'$PREFIX'/lib/plantuml.jar" "$@"' >> $PREFIX/bin/plantuml
chmod +x "${PREFIX}/bin/plantuml"
