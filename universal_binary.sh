# Validate arguments

if [ -z "$1" -o -z "$2" ]; then
  echo "\n** ERROR **\n"
  echo "You have to define 'target' and 'libName' as argument"
  echo "Example: 'universal_binary.sh MyTarget lib.a'"
  exit 1
fi

TARGET=$1 # The name of the Xcode target
FILE_NAME=$2 # It has to match the library that is defined in the Xcode target

ACTION="clean build" 
DEVICE=iphoneos
SIMULATOR=iphonesimulator

# Build for all platforms

echo "Building universal library for target '${TARGET}'\n\n"

xcodebuild -configuration Release -target ${TARGET} -sdk ${DEVICE} ${ACTION} RUN_CLANG_STATIC_ANALYZER=NO
xcodebuild -configuration Release -target ${TARGET} -sdk ${SIMULATOR} ${ACTION} RUN_CLANG_STATIC_ANALYZER=NO

# Merge all platform binaries as a fat binary

RELEASE_DEVICE_DIR=build/Release-iphoneos
RELEASE_SIMULATOR_DIR=build/Release-iphonesimulator
RELEASE_UNIVERSAL_DIR=build/Release-universal

rm -rf "${RELEASE_UNIVERSAL_DIR}"
mkdir "${RELEASE_UNIVERSAL_DIR}"
cp -r "${RELEASE_DEVICE_DIR}/usr" "${RELEASE_UNIVERSAL_DIR}"

lipo -create -output "${RELEASE_UNIVERSAL_DIR}/${FILE_NAME}" "${RELEASE_DEVICE_DIR}/${FILE_NAME}" "${RELEASE_SIMULATOR_DIR}/${FILE_NAME}"

# Output results

echo "\nWrote universal lib to:"
echo "`pwd`/${RELEASE_UNIVERSAL_DIR}"

echo "\n\n** DONE **"
