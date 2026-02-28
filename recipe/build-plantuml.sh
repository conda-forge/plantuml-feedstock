#!/usr/bin/env bash
set -eux -o pipefail

export MAVEN_OPTS="-Xmx1G"

ant -noinput

mkdir -p "${PREFIX}/lib" "${PREFIX}/bin"

cp plantuml.jar "${PREFIX}/lib/plantuml.jar"

cat << 'EOF' | sed 's#__PREFIX__#'"${PREFIX}"'#' > "${PREFIX}/bin/plantuml"
#!/usr/bin/env bash
java -Xmx500M -jar "__PREFIX__/lib/plantuml.jar" "$@"
EOF

chmod +x "${PREFIX}/bin/plantuml"

echo "----------------------- generated wrapper script ------------------------"
cat "${PREFIX}/bin/plantuml"
echo "-------------------------------------------------------------------------"
