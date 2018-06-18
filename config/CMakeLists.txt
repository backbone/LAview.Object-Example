CONFIGURE_FILE ("${CMAKE_CURRENT_SOURCE_DIR}/config.h.in"
                "${CMAKE_CURRENT_BINARY_DIR}/config.h")

SET (GSchemaFile "ws.backbone.laview.object-example")
INCLUDE (GSchemaCommonRules)
