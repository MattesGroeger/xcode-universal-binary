GET=$1 # e.g. 'Library'                                                                                                                             
FILE_NAME=$2 # e.g. 'lib.a'                                                                                                                            
                                                                                                                                                       
ACTION="clean build"                                                                                                                                   
DEVICE=iphoneos                                                                                                                                        
SIMULATOR=iphonesimulator                                                                                                                              
                                                                                                                                                       
# Build for all platforms                                                                                                               
                                                                                                                                                       
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
echo "`pwd`/${RELEASE_UNIVERSAL_DIR}/${FILE_NAME}"                                                                                                     
                                                                                                                                                       
echo "\n\n** DONE **"
