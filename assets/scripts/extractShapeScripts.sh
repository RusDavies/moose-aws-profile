#!/bin/bash

function Error() {
  printf "ERROR: $1.\n" 1>&2 && exit 1
}

[ -z "$1" ] && Error "Incorrect number of params."
[ ! -e "$1" ] && Error "Source file doesn't exist."

XPATHBASE="/MDG.Technology/UMLProfiles/UMLProfile/Content/Stereotypes/Stereotype"
TARGETDIR="${1%.xml}_ShapeScripts"

MTS=$(xmlstarlet sel -T -t -v "${XPATHBASE}/@metatype" $1)

[ -z "$MTS" ] && Error "No metatypes found in source file."

mkdir -p ${TARGETDIR}

for MT in ${MTS}
do
  printf "\n\n=====================\nExtracting ShapeScript for metatype=${MT}\n"
  xmlstarlet sel -t -v "${XPATHBASE}[@metatype='${MT}']/Image[1]" $1 | \
    base64 -i -d | \
    funzip | \
    tr -d '\000' | \
    tee ${TARGETDIR}/${MT}.ShapeScript
done

exit 0

