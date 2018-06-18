SET (CONTACT "backbone@backbone.ws")
SET (DEBIAN_DEPENDENCIES "laview-core-0 >= 0.0.0, laview-data-example-0 (>= 0.0.0)")
SET (DEBIAN_SECTION "TeX")
SET (REDHAT_DEPENDENCIES "laview-core-0 >= 0.0.0, laview-data-example-0 >= 0.0.0")
SET (REDHAT_SECTION "Applications/Publishing")
SET (LICENSE "LGPLv3+")
SET (WIN32_UNINSTALL_NAME "LAvPlOEx") # <= 8 symbols for the name
SET (CPACK_NSIS_MENU_LINKS "https://git.backbone.ws/kolan/LAview.Object-Example"
                           "Homepage for LAview/Object-Example")
INCLUDE (CPackCommonRules)
