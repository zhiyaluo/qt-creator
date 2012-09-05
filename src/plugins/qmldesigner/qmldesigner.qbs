import qbs.base 1.0

import "../QtcPlugin.qbs" as QtcPlugin

QtcPlugin {
    name: "QmlDesigner"

    condition: qtcore.versionMajor == 4
    Depends { id: qtcore; name: "Qt.core" }
    Depends { name: "Qt"; submodules: ["widgets", "quick1"] }
    Depends { name: "Core" }
    Depends { name: "QmlJS" }
    Depends { name: "QmlEditorWidgets" }
    Depends { name: "TextEditor" }
    Depends { name: "QmlJSEditor" }
    Depends { name: "Qt4ProjectManager" }
    Depends { name: "QmlProjectManager" }
    Depends { name: "ProjectExplorer" }
    Depends { name: "LanguageUtils" }
    Depends { name: "QtSupport" }

    Depends { name: "cpp" }
    cpp.defines: base.concat(["QWEAKPOINTER_ENABLE_ARROW"])
    cpp.includePaths: [
        ".",
        "designercore",
        "designercore/include",
        "../../../share/qtcreator/qml/qmlpuppet/interfaces",
        "../../../share/qtcreator/qml/qmlpuppet/container",
        "../../../share/qtcreator/qml/qmlpuppet/commands",
        "components/integration",
        "components/propertyeditor",
        "components/formeditor",
        "components/itemlibrary",
        "components/navigator",
        "components/pluginmanager",
        "components/stateseditor",
        "..",
        "../../libs",
        buildDirectory
    ]

    files: [
        "designercore/filemanager/qmlrewriter.h",
        "designercore/filemanager/qmlrefactoring.h",
        "designercore/filemanager/changeobjecttypevisitor.h",
        "designercore/filemanager/changepropertyvisitor.h",
        "designercore/filemanager/removeuiobjectmembervisitor.h",
        "designercore/filemanager/removepropertyvisitor.h",
        "designercore/filemanager/addpropertyvisitor.h",
        "designercore/filemanager/moveobjectvisitor.h",
        "designercore/filemanager/addobjectvisitor.h",
        "designercore/filemanager/addarraymembervisitor.h",
        "designercore/filemanager/astobjecttextextractor.h",
        "designercore/filemanager/objectlengthcalculator.h",
        "designercore/filemanager/firstdefinitionfinder.h",
        "designercore/filemanager/moveobjectbeforeobjectvisitor.h",
        "designercore/filemanager/changeimportsvisitor.h",
        "designercore/include/nodeinstance.h",
        "designercore/instances/nodeinstanceserverproxy.h",
        "../../../share/qtcreator/qml/qmlpuppet/interfaces/nodeinstanceclientinterface.h",
        "../../../share/qtcreator/qml/qmlpuppet/interfaces/nodeinstanceserverinterface.h",
        "../../../share/qtcreator/qml/qmlpuppet/interfaces/commondefines.h",
        "../../../share/qtcreator/qml/qmlpuppet/commands/synchronizecommand.h",
        "../../../share/qtcreator/qml/qmlpuppet/commands/tokencommand.h",
        "../../../share/qtcreator/qml/qmlpuppet/commands/componentcompletedcommand.h",
        "../../../share/qtcreator/qml/qmlpuppet/commands/completecomponentcommand.h",
        "../../../share/qtcreator/qml/qmlpuppet/commands/statepreviewimagechangedcommand.h",
        "../../../share/qtcreator/qml/qmlpuppet/commands/childrenchangedcommand.h",
        "../../../share/qtcreator/qml/qmlpuppet/commands/changebindingscommand.h",
        "../../../share/qtcreator/qml/qmlpuppet/commands/changefileurlcommand.h",
        "../../../share/qtcreator/qml/qmlpuppet/commands/changeidscommand.h",
        "../../../share/qtcreator/qml/qmlpuppet/commands/changenodesourcecommand.h",
        "../../../share/qtcreator/qml/qmlpuppet/commands/changestatecommand.h",
        "../../../share/qtcreator/qml/qmlpuppet/commands/changevaluescommand.h",
        "../../../share/qtcreator/qml/qmlpuppet/commands/createscenecommand.h",
        "../../../share/qtcreator/qml/qmlpuppet/commands/clearscenecommand.h",
        "../../../share/qtcreator/qml/qmlpuppet/commands/createinstancescommand.h",
        "../../../share/qtcreator/qml/qmlpuppet/commands/informationchangedcommand.h",
        "../../../share/qtcreator/qml/qmlpuppet/commands/pixmapchangedcommand.h",
        "../../../share/qtcreator/qml/qmlpuppet/commands/removeinstancescommand.h",
        "../../../share/qtcreator/qml/qmlpuppet/commands/removepropertiescommand.h",
        "../../../share/qtcreator/qml/qmlpuppet/commands/reparentinstancescommand.h",
        "../../../share/qtcreator/qml/qmlpuppet/commands/valueschangedcommand.h",
        "../../../share/qtcreator/qml/qmlpuppet/commands/changeauxiliarycommand.h",
        "../../../share/qtcreator/qml/qmlpuppet/container/addimportcontainer.h",
        "../../../share/qtcreator/qml/qmlpuppet/container/imagecontainer.h",
        "../../../share/qtcreator/qml/qmlpuppet/container/idcontainer.h",
        "../../../share/qtcreator/qml/qmlpuppet/container/informationcontainer.h",
        "../../../share/qtcreator/qml/qmlpuppet/container/instancecontainer.h",
        "../../../share/qtcreator/qml/qmlpuppet/container/reparentcontainer.h",
        "../../../share/qtcreator/qml/qmlpuppet/container/propertyabstractcontainer.h",
        "../../../share/qtcreator/qml/qmlpuppet/container/propertybindingcontainer.h",
        "../../../share/qtcreator/qml/qmlpuppet/container/propertyvaluecontainer.h",
        "designercore/include/corelib_global.h",
        "designercore/include/abstractview.h",
        "designercore/include/nodeinstanceview.h",
        "designercore/include/rewriterview.h",
        "designercore/include/metainfo.h",
        "designercore/include/metainfoparser.h",
        "designercore/include/nodemetainfo.h",
        "designercore/include/itemlibraryinfo.h",
        "designercore/model/internalproperty.h",
        "designercore/include/modelnode.h",
        "designercore/include/model.h",
        "designercore/include/nodeproperty.h",
        "designercore/include/subcomponentmanager.h",
        "designercore/include/propertycontainer.h",
        "designercore/model/internalnode_p.h",
        "designercore/model/model_p.h",
        "designercore/model/painteventfilter_p.h",
        "designercore/model/propertyparser.h",
        "designercore/pluginmanager/widgetpluginmanager.h",
        "designercore/pluginmanager/widgetpluginpath.h",
        "designercore/include/exception.h",
        "designercore/include/invalidreparentingexception.h",
        "designercore/include/invalidmetainfoexception.h",
        "designercore/include/invalidargumentexception.h",
        "designercore/include/notimplementedexception.h",
        "designercore/include/invalidpropertyexception.h",
        "designercore/include/invalidmodelstateexception.h",
        "designercore/include/removebasestateexception.h",
        "designercore/include/invalididexception.h",
        "designercore/model/variantparser.h",
        "designercore/include/propertynode.h",
        "designercore/include/invalidslideindexexception.h",
        "designercore/include/import.h",
        "designercore/include/invalidqmlsourceexception.h",
        "designercore/model/viewlogger.h",
        "designercore/model/internalvariantproperty.h",
        "designercore/model/internalnodelistproperty.h",
        "designercore/include/variantproperty.h",
        "designercore/include/nodelistproperty.h",
        "designercore/include/abstractproperty.h",
        "designercore/model/internalbindingproperty.h",
        "designercore/include/bindingproperty.h",
        "designercore/model/internalnodeproperty.h",
        "designercore/model/internalnodeabstractproperty.h",
        "designercore/include/nodeabstractproperty.h",
        "designercore/include/plaintexteditmodifier.h",
        "designercore/include/basetexteditmodifier.h",
        "designercore/include/componenttextmodifier.h",
        "designercore/include/textmodifier.h",
        "designercore/model/modeltotextmerger.h",
        "designercore/model/texttomodelmerger.h",
        "designercore/include/qmlmodelview.h",
        "designercore/include/qmlitemnode.h",
        "designercore/include/qmlstate.h",
        "designercore/include/qmlchangeset.h",
        "designercore/include/qmlmodelnodefacade.h",
        "designercore/include/forwardview.h",
        "designercore/include/qmlobjectnode.h",
        "designercore/include/qmlanchors.h",
        "designercore/rewritertransaction.h",
        "designercore/model/rewriteaction.h",
        "designercore/include/modelnodepositionstorage.h",
        "designercore/model/modelnodepositionrecalculator.h",
        "designercore/model/rewriteactioncompressor.h",
        "designercore/model/qmltextgenerator.h",
        "designercore/include/modelmerger.h",
        "designercore/include/mathutils.h",
        "designercore/include/customnotifications.h",
        "designercore/include/rewritingexception.h",
        "components/componentscore/modelnodecontextmenu.h",
        "designercore/include/basetexteditmodifier.h",
        "components/integration/integrationcore.h",
        "components/integration/designdocumentcontrollerview.h",
        "components/integration/designdocumentcontroller.h",
        "components/integration/utilitypanelcontroller.h",
        "components/integration/stackedutilitypanelcontroller.h",
        "components/integration/componentaction.h",
        "components/integration/componentview.h",
        "components/integration/xuifiledialog.h",
        "components/integration/integrationcore.cpp",
        "components/integration/designdocumentcontroller.cpp",
        "components/integration/designdocumentcontrollerview.cpp",
        "components/integration/utilitypanelcontroller.cpp",
        "components/integration/stackedutilitypanelcontroller.cpp",
        "components/integration/componentaction.cpp",
        "components/integration/componentview.cpp",
        "components/integration/xuifiledialog.cpp",
        "components/propertyeditor/propertyeditor.h",
        "components/propertyeditor/qmlanchorbindingproxy.h",
        "components/propertyeditor/resetwidget.h",
        "components/propertyeditor/qlayoutobject.h",
        "components/propertyeditor/basiclayouts.h",
        "components/propertyeditor/basicwidgets.h",
        "components/propertyeditor/behaviordialog.h",
        "components/propertyeditor/qproxylayoutitem.h",
        "components/propertyeditor/layoutwidget.h",
        "components/propertyeditor/filewidget.h",
        "components/propertyeditor/propertyeditorvalue.h",
        "components/propertyeditor/fontwidget.h",
        "components/propertyeditor/originwidget.h",
        "components/propertyeditor/siblingcombobox.h",
        "components/propertyeditor/propertyeditortransaction.h",
        "components/propertyeditor/designerpropertymap.h",
        "components/propertyeditor/propertyeditorcontextobject.h",
        "components/propertyeditor/declarativewidgetview.h",
        "components/propertyeditor/gradientlineqmladaptor.h",
        "components/propertyeditor/propertyeditor.cpp",
        "components/propertyeditor/qmlanchorbindingproxy.cpp",
        "components/propertyeditor/resetwidget.cpp",
        "components/propertyeditor/qlayoutobject.cpp",
        "components/propertyeditor/basiclayouts.cpp",
        "components/propertyeditor/basicwidgets.cpp",
        "components/propertyeditor/behaviordialog.cpp",
        "components/propertyeditor/qproxylayoutitem.cpp",
        "components/propertyeditor/layoutwidget.cpp",
        "components/propertyeditor/filewidget.cpp",
        "components/propertyeditor/propertyeditorvalue.cpp",
        "components/propertyeditor/fontwidget.cpp",
        "components/propertyeditor/originwidget.cpp",
        "components/propertyeditor/siblingcombobox.cpp",
        "components/propertyeditor/propertyeditortransaction.cpp",
        "components/propertyeditor/propertyeditorcontextobject.cpp",
        "components/propertyeditor/declarativewidgetview.cpp",
        "components/propertyeditor/gradientlineqmladaptor.cpp",
        "components/propertyeditor/propertyeditor.qrc",
        "components/formeditor/formeditorscene.h",
        "components/formeditor/formeditorwidget.h",
        "components/formeditor/formeditoritem.h",
        "components/formeditor/formeditorview.h",
        "components/formeditor/selectiontool.h",
        "components/formeditor/abstractformeditortool.h",
        "components/formeditor/controlelement.h",
        "components/formeditor/resizemanipulator.h",
        "components/formeditor/movemanipulator.h",
        "components/formeditor/layeritem.h",
        "components/formeditor/itemutilfunctions.h",
        "components/formeditor/selectionrectangle.h",
        "components/formeditor/rubberbandselectionmanipulator.h",
        "components/formeditor/movetool.h",
        "components/formeditor/selectionindicator.h",
        "components/formeditor/snappinglinecreator.h",
        "components/formeditor/snapper.h",
        "components/formeditor/onedimensionalcluster.h",
        "components/formeditor/singleselectionmanipulator.h",
        "components/formeditor/scalemanipulator.h",
        "components/formeditor/resizetool.h",
        "components/formeditor/resizeindicator.h",
        "components/formeditor/scaleitem.h",
        "components/formeditor/resizecontroller.h",
        "components/formeditor/resizehandleitem.h",
        "components/formeditor/dragtool.h",
        "components/formeditor/toolbox.h",
        "components/formeditor/zoomaction.h",
        "components/formeditor/formeditorgraphicsview.h",
        "components/formeditor/numberseriesaction.h",
        "components/formeditor/lineeditaction.h",
        "components/formeditor/formeditoritem.cpp",
        "components/formeditor/formeditorview.cpp",
        "components/formeditor/formeditorscene.cpp",
        "components/formeditor/formeditorwidget.cpp",
        "components/formeditor/selectiontool.cpp",
        "components/formeditor/abstractformeditortool.cpp",
        "components/formeditor/controlelement.cpp",
        "components/formeditor/resizemanipulator.cpp",
        "components/formeditor/movemanipulator.cpp",
        "components/formeditor/layeritem.cpp",
        "components/formeditor/itemutilfunctions.cpp",
        "components/formeditor/selectionrectangle.cpp",
        "components/formeditor/rubberbandselectionmanipulator.cpp",
        "components/formeditor/movetool.cpp",
        "components/formeditor/selectionindicator.cpp",
        "components/formeditor/snappinglinecreator.cpp",
        "components/formeditor/snapper.cpp",
        "components/formeditor/onedimensionalcluster.cpp",
        "components/formeditor/singleselectionmanipulator.cpp",
        "components/formeditor/scalemanipulator.cpp",
        "components/formeditor/resizetool.cpp",
        "components/formeditor/resizeindicator.cpp",
        "components/formeditor/scaleitem.cpp",
        "components/formeditor/resizecontroller.cpp",
        "components/formeditor/resizehandleitem.cpp",
        "components/formeditor/dragtool.cpp",
        "components/formeditor/toolbox.cpp",
        "components/formeditor/zoomaction.cpp",
        "components/formeditor/formeditorgraphicsview.cpp",
        "components/formeditor/numberseriesaction.cpp",
        "components/formeditor/lineeditaction.cpp",
        "components/formeditor/formeditor.qrc",
        "qmldesignerconstants.h",
        "qmldesignerplugin.h",
        "designmodewidget.h",
        "designersettings.h",
        "settingspage.h",
        "designmodecontext.h",
        "styledoutputpaneplaceholder.h",
        "designercore/filemanager/qmlrewriter.cpp",
        "designercore/filemanager/qmlrefactoring.cpp",
        "designercore/filemanager/changeobjecttypevisitor.cpp",
        "designercore/filemanager/changepropertyvisitor.cpp",
        "designercore/filemanager/removeuiobjectmembervisitor.cpp",
        "designercore/filemanager/removepropertyvisitor.cpp",
        "designercore/filemanager/addpropertyvisitor.cpp",
        "designercore/filemanager/moveobjectvisitor.cpp",
        "designercore/filemanager/addobjectvisitor.cpp",
        "designercore/filemanager/addarraymembervisitor.cpp",
        "designercore/filemanager/astobjecttextextractor.cpp",
        "designercore/filemanager/objectlengthcalculator.cpp",
        "designercore/filemanager/firstdefinitionfinder.cpp",
        "designercore/filemanager/moveobjectbeforeobjectvisitor.cpp",
        "designercore/filemanager/changeimportsvisitor.cpp",
        "designercore/instances/nodeinstanceserverproxy.cpp",
        "designercore/instances/nodeinstance.cpp",
        "designercore/instances/nodeinstanceview.cpp",
        "../../../share/qtcreator/qml/qmlpuppet/interfaces/nodeinstanceserverinterface.cpp",
        "../../../share/qtcreator/qml/qmlpuppet/commands/synchronizecommand.cpp",
        "../../../share/qtcreator/qml/qmlpuppet/commands/tokencommand.cpp",
        "../../../share/qtcreator/qml/qmlpuppet/commands/componentcompletedcommand.cpp",
        "../../../share/qtcreator/qml/qmlpuppet/commands/completecomponentcommand.cpp",
        "../../../share/qtcreator/qml/qmlpuppet/commands/statepreviewimagechangedcommand.cpp",
        "../../../share/qtcreator/qml/qmlpuppet/commands/childrenchangedcommand.cpp",
        "../../../share/qtcreator/qml/qmlpuppet/commands/changebindingscommand.cpp",
        "../../../share/qtcreator/qml/qmlpuppet/commands/changefileurlcommand.cpp",
        "../../../share/qtcreator/qml/qmlpuppet/commands/changeidscommand.cpp",
        "../../../share/qtcreator/qml/qmlpuppet/commands/changenodesourcecommand.cpp",
        "../../../share/qtcreator/qml/qmlpuppet/commands/changestatecommand.cpp",
        "../../../share/qtcreator/qml/qmlpuppet/commands/changevaluescommand.cpp",
        "../../../share/qtcreator/qml/qmlpuppet/commands/informationchangedcommand.cpp",
        "../../../share/qtcreator/qml/qmlpuppet/commands/removeinstancescommand.cpp",
        "../../../share/qtcreator/qml/qmlpuppet/commands/removepropertiescommand.cpp",
        "../../../share/qtcreator/qml/qmlpuppet/commands/reparentinstancescommand.cpp",
        "../../../share/qtcreator/qml/qmlpuppet/commands/valueschangedcommand.cpp",
        "../../../share/qtcreator/qml/qmlpuppet/commands/clearscenecommand.cpp",
        "../../../share/qtcreator/qml/qmlpuppet/commands/createinstancescommand.cpp",
        "../../../share/qtcreator/qml/qmlpuppet/commands/createscenecommand.cpp",
        "../../../share/qtcreator/qml/qmlpuppet/commands/pixmapchangedcommand.cpp",
        "../../../share/qtcreator/qml/qmlpuppet/commands/changeauxiliarycommand.cpp",
        "../../../share/qtcreator/qml/qmlpuppet/container/addimportcontainer.cpp",
        "../../../share/qtcreator/qml/qmlpuppet/container/imagecontainer.cpp",
        "../../../share/qtcreator/qml/qmlpuppet/container/idcontainer.cpp",
        "../../../share/qtcreator/qml/qmlpuppet/container/informationcontainer.cpp",
        "../../../share/qtcreator/qml/qmlpuppet/container/instancecontainer.cpp",
        "../../../share/qtcreator/qml/qmlpuppet/container/reparentcontainer.cpp",
        "../../../share/qtcreator/qml/qmlpuppet/container/propertyabstractcontainer.cpp",
        "../../../share/qtcreator/qml/qmlpuppet/container/propertybindingcontainer.cpp",
        "../../../share/qtcreator/qml/qmlpuppet/container/propertyvaluecontainer.cpp",
        "designercore/model/abstractview.cpp",
        "designercore/model/rewriterview.cpp",
        "designercore/metainfo/metainfo.cpp",
        "designercore/metainfo/metainfoparser.cpp",
        "designercore/metainfo/nodemetainfo.cpp",
        "designercore/metainfo/itemlibraryinfo.cpp",
        "designercore/metainfo/subcomponentmanager.cpp",
        "designercore/model/internalproperty.cpp",
        "designercore/model/model.cpp",
        "designercore/model/modelnode.cpp",
        "designercore/model/painteventfilter.cpp",
        "designercore/model/internalnode.cpp",
        "designercore/model/propertyparser.cpp",
        "designercore/model/propertycontainer.cpp",
        "designercore/pluginmanager/widgetpluginmanager.cpp",
        "designercore/pluginmanager/widgetpluginpath.cpp",
        "designercore/exceptions/exception.cpp",
        "designercore/exceptions/invalidpropertyexception.cpp",
        "designercore/exceptions/invalidmodelnodeexception.cpp",
        "designercore/exceptions/invalidreparentingexception.cpp",
        "designercore/exceptions/invalidmetainfoexception.cpp",
        "designercore/exceptions/invalidargumentexception.cpp",
        "designercore/exceptions/notimplementedexception.cpp",
        "designercore/model/variantparser.cpp",
        "designercore/exceptions/invalidmodelstateexception.cpp",
        "designercore/exceptions/removebasestateexception.cpp",
        "designercore/exceptions/invalididexception.cpp",
        "designercore/model/propertynode.cpp",
        "designercore/exceptions/invalidslideindexexception.cpp",
        "designercore/model/import.cpp",
        "designercore/exceptions/invalidqmlsourceexception.cpp",
        "designercore/model/viewlogger.cpp",
        "designercore/model/internalvariantproperty.cpp",
        "designercore/model/internalnodelistproperty.cpp",
        "designercore/model/variantproperty.cpp",
        "designercore/model/nodelistproperty.cpp",
        "designercore/model/abstractproperty.cpp",
        "designercore/model/internalbindingproperty.cpp",
        "designercore/model/bindingproperty.cpp",
        "designercore/model/internalnodeproperty.cpp",
        "designercore/model/internalnodeabstractproperty.cpp",
        "designercore/model/nodeabstractproperty.cpp",
        "designercore/model/nodeproperty.cpp",
        "designercore/model/modeltotextmerger.cpp",
        "designercore/model/texttomodelmerger.cpp",
        "designercore/model/plaintexteditmodifier.cpp",
        "designercore/model/componenttextmodifier.cpp",
        "designercore/model/textmodifier.cpp",
        "designercore/model/qmlmodelview.cpp",
        "designercore/model/qmlitemnode.cpp",
        "designercore/model/qmlstate.cpp",
        "designercore/model/qmlchangeset.cpp",
        "designercore/model/qmlmodelnodefacade.cpp",
        "designercore/model/qmlobjectnode.cpp",
        "designercore/model/qmlanchors.cpp",
        "designercore/rewritertransaction.cpp",
        "designercore/model/rewriteaction.cpp",
        "designercore/model/modelnodepositionstorage.cpp",
        "designercore/model/modelnodepositionrecalculator.cpp",
        "designercore/model/rewriteactioncompressor.cpp",
        "designercore/model/qmltextgenerator.cpp",
        "designercore/model/modelmerger.cpp",
        "designercore/exceptions/rewritingexception.cpp",
        "components/componentcore/modelnodecontextmenu.cpp",
        "designercore/model/basetexteditmodifier.cpp",
        "components/propertyeditor/behaviordialog.ui",
        "components/itemlibrary/itemlibraryview.cpp",
        "components/itemlibrary/itemlibrarywidget.cpp",
        "components/itemlibrary/customdraganddrop.cpp",
        "components/itemlibrary/itemlibrarymodel.cpp",
        "components/itemlibrary/itemlibrarycomponents.cpp",
        "components/itemlibrary/itemlibraryimageprovider.cpp",
        "components/itemlibrary/itemlibraryview.h",
        "components/itemlibrary/itemlibrarywidget.h",
        "components/itemlibrary/customdraganddrop.h",
        "components/itemlibrary/itemlibrarymodel.h",
        "components/itemlibrary/itemlibrarycomponents.h",
        "components/itemlibrary/itemlibraryimageprovider.h",
        "components/itemlibrary/itemlibrary.qrc",
        "components/navigator/navigatorview.h",
        "components/navigator/navigatortreemodel.h",
        "components/navigator/navigatorwidget.h",
        "components/navigator/navigatortreeview.h",
        "components/navigator/navigatorview.cpp",
        "components/navigator/navigatortreemodel.cpp",
        "components/navigator/navigatorwidget.cpp",
        "components/navigator/navigatortreeview.cpp",
        "components/navigator/navigator.qrc",
        "components/pluginmanager/pluginmanager.cpp",
        "components/pluginmanager/pluginpath.cpp",
        "components/pluginmanager/iplugin.cpp",
        "components/pluginmanager/pluginmanager.h",
        "components/pluginmanager/pluginpath.h",
        "components/pluginmanager/iplugin.h",
        "components/stateseditor/stateseditorwidget.h",
        "components/stateseditor/stateseditormodel.h",
        "components/stateseditor/stateseditorview.h",
        "components/stateseditor/stateseditorimageprovider.cpp",
        "components/stateseditor/stateseditorwidget.cpp",
        "components/stateseditor/stateseditormodel.cpp",
        "components/stateseditor/stateseditorview.cpp",
        "components/stateseditor/stateseditorimageprovider.cpp",
        "components/stateseditor/stateseditor.qrc",
        "components/stateseditor/stateslist.qml",
        "components/stateseditor/HorizontalScrollBar.qml",
        "qmldesignerplugin.cpp",
        "designmodewidget.cpp",
        "designersettings.cpp",
        "settingspage.cpp",
        "designmodecontext.cpp",
        "styledoutputpaneplaceholder.cpp",
        "settingspage.ui",
        "components/resources/resources.qrc",
        "components/itemlibrary/qml/Selector.qml",
        "components/itemlibrary/qml/SectionView.qml",
        "components/itemlibrary/qml/Scrollbar.qml",
        "components/itemlibrary/qml/ItemView.qml",
        "components/itemlibrary/qml/ItemsViewStyle.qml",
        "components/itemlibrary/qml/ItemsView.qml"
    ]
}

