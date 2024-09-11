#! /usr/bin/env nix-shell
#! nix-shell -i bash -p xmlstarlet

# source file
INPUT=$1

OUT_DIR="${INPUT}_layers"

# layer name on each line
LAYERS=$(xmlstarlet sel -N s="http://www.w3.org/2000/svg" -N i="http://www.inkscape.org/namespaces/inkscape" -t -v "//s:svg/s:g/@i:label" $INPUT)

mkdir -p "$OUT_DIR"

for LAYER in $LAYERS; do
    echo "Processing layer: $LAYER"
    xmlstarlet ed -N s="http://www.w3.org/2000/svg" \
    -N i="http://www.inkscape.org/namespaces/inkscape" \
    -d "//s:svg/s:g[not(@i:label='$LAYER')]" \sel
    $INPUT > "$OUT_DIR/$LAYER.svg"
done