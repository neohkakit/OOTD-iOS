#!/bin/sh

RESOURCES_TO_COPY=${PODS_ROOT}/resources-to-copy.txt
touch "$RESOURCES_TO_COPY"

install_resource()
{
  case $1 in
    *.storyboard)
      echo "ibtool --errors --warnings --notices --output-format human-readable-text --compile ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .storyboard`.storyboardc ${PODS_ROOT}/$1 --sdk ${SDKROOT}"
      ibtool --errors --warnings --notices --output-format human-readable-text --compile "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .storyboard`.storyboardc" "${PODS_ROOT}/$1" --sdk "${SDKROOT}"
      ;;
    *.xib)
        echo "ibtool --errors --warnings --notices --output-format human-readable-text --compile ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .xib`.nib ${PODS_ROOT}/$1 --sdk ${SDKROOT}"
      ibtool --errors --warnings --notices --output-format human-readable-text --compile "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename \"$1\" .xib`.nib" "${PODS_ROOT}/$1" --sdk "${SDKROOT}"
      ;;
    *.framework)
      echo "rsync -rp ${PODS_ROOT}/$1 ${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      rsync -rp "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
      ;;
    *.xcdatamodeld)
      echo "xcrun momc ${PODS_ROOT}/$1 ${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename $1 .xcdatamodeld`.momd"
      xcrun momc "${PODS_ROOT}/$1" "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/`basename $1 .xcdatamodeld`.momd"
      ;;
    *)
      echo "${PODS_ROOT}/$1"
      echo "${PODS_ROOT}/$1" >> "$RESOURCES_TO_COPY"
      ;;
  esac
}
install_resource 'DYRateView/DYRateView/Resources/StarEmpty.png'
install_resource 'DYRateView/DYRateView/Resources/StarEmpty@2x.png'
install_resource 'DYRateView/DYRateView/Resources/StarEmptyLarge.png'
install_resource 'DYRateView/DYRateView/Resources/StarEmptyLarge@2x.png'
install_resource 'DYRateView/DYRateView/Resources/StarFull.png'
install_resource 'DYRateView/DYRateView/Resources/StarFull@2x.png'
install_resource 'DYRateView/DYRateView/Resources/StarFullLarge.png'
install_resource 'DYRateView/DYRateView/Resources/StarFullLarge@2x.png'
install_resource 'SVProgressHUD/SVProgressHUD/SVProgressHUD.bundle'
install_resource 'SVWebViewController/SVWebViewController/SVWebViewController.bundle'
install_resource 'US2FormValidator/US2FormValidationFramework/US2Localizable/da.lproj'
install_resource 'US2FormValidator/US2FormValidationFramework/US2Localizable/de.lproj'
install_resource 'US2FormValidator/US2FormValidationFramework/US2Localizable/en.lproj'
install_resource 'US2FormValidator/US2FormValidationFramework/US2Localizable/fr.lproj'
install_resource 'US2FormValidator/US2FormValidationFramework/US2Localizable/it.lproj'
install_resource 'US2FormValidator/US2FormValidationFramework/US2Localizable/ja.lproj'
install_resource 'US2FormValidator/US2FormValidationFramework/US2Localizable/ko.lproj'
install_resource 'US2FormValidator/US2FormValidationFramework/US2Localizable/nb.lproj'
install_resource 'US2FormValidator/US2FormValidationFramework/US2Localizable/pl.lproj'
install_resource 'US2FormValidator/US2FormValidationFramework/US2Localizable/pt-PT.lproj'
install_resource 'US2FormValidator/US2FormValidationFramework/US2Localizable/ro.lproj'
install_resource 'US2FormValidator/US2FormValidationFramework/US2Localizable/ru.lproj'
install_resource 'US2FormValidator/US2FormValidationFramework/US2Localizable/sv.lproj'
install_resource 'iRate/iRate/iRate.bundle'

rsync -avr --no-relative --exclude '*/.svn/*' --files-from="$RESOURCES_TO_COPY" / "${CONFIGURATION_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
rm "$RESOURCES_TO_COPY"
