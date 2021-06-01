import QtQuick 2.0
import Sailfish.Silica 1.0
import FileCase 1.0

Page {
    id: dropboxpage

    allowedOrientations: appWindow.pagesOrientations

    property bool loaded: false
    property string action: "nothing"
    property string sourcePath: ""
    property string sourcePathType: ""


    onStatusChanged: {
        if (status === PageStatus.Activating) {
            downloadValue.value = getName(config.readConfig("Dropbox/download_folder", config.getHome() + "/Downloads"))
            uploadValue.value = getName(config.readConfig("Dropbox/upload_folder","/||root"))
        }
    }

    function getName(text) {
        var res = text.split("||")
        res = res[0]
        res = res.split('/')
        res = res[res.length-1]
        if (res==="") res = "/"
        return res;
    }

    SilicaFlickable {
        id: listado
        anchors.fill: parent
        contentHeight: column1.height + Theme.paddingLarge
        clip: true

        Column {
            id: column1
            anchors.left: parent.left
            width: parent.width
            //spacing: Theme.paddingLarge


            MyHeader {
                title: qsTr("Settings")
            }

            SectionHeader {
                text: qsTr("Account")
            }

            Item {
                anchors.left: parent.left
                anchors.leftMargin: Theme.paddingLarge
                anchors.right: parent.right
                anchors.rightMargin: Theme.paddingLarge
                height: Theme.itemSizeExtraLarge


                Image {
                    id: userPic
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    source: dropboxAccount.picture
                    asynchronous: true
                    smooth: true
                    height: Theme.itemSizeSmall
                    width: height
                    fillMode: Image.PreserveAspectFit
                }

                Column {
                    anchors.left: dropboxAccount.picture!==""? userPic.right : parent.left
                    anchors.leftMargin: dropboxAccount.picture!==""? Theme.paddingMedium : 0
                    anchors.verticalCenter: userPic.verticalCenter

                    Label {
                        text: dropboxAccount.user
                    }

                    Label {
                        text: dropboxAccount.email
                        color: Theme.secondaryColor
                        font.pixelSize: Theme.fontSizeSmall
                    }
                }


            }

            Button {
                text: qsTr("Remove account")
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    //dropboxPageLoaded = false
                    config.removeConfig("Dropbox")
                    cloudModel.clear()
                    utilities.loadClouds()
                    pageStack.replaceAbove(null, mainPage)

                }
            }

            SectionHeader {
                text: qsTr("Storage")
            }


            ProgressCircleBase {
                width: colSpace.width + Theme.paddingLarge*3
                height: width
                anchors.horizontalCenter: parent.horizontalCenter
                value: dropboxAccount.spaceUsed / dropboxAccount.spaceTotal
                borderWidth: 2
                progressColor: Theme.highlightColor
                backgroundColor: Theme.rgba(Theme.secondaryHighlightColor, 0.5)

                Column {
                    id: colSpace
                    width: spaceLine.width
                    anchors.centerIn: parent

                    Text {
                        id: usedSpaceLabel
                        color: Theme.highlightColor
                        font.pixelSize: Theme.fontSizeLarge
                        width: paintedWidth
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: dropboxAccount.spaceUsedText
                    }
                    Rectangle {
                        id: spaceLine
                        color: Theme.rgba(Theme.secondaryHighlightColor, 0.5)
                        width: Math.max(totalSpaceLabel.paintedWidth, usedSpaceLabel.paintedWidth)
                        height: 2
                    }
                    Text {
                        id: totalSpaceLabel
                        color: Theme.rgba(Theme.secondaryHighlightColor, 0.7)
                        font.pixelSize: Theme.fontSizeLarge
                        width: paintedWidth
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: dropboxAccount.spaceTotalText
                    }
                }


            }


            SectionHeader {
                text: qsTr("Transfers")
            }

            ValueButton {
                id: downloadValue
                label: qsTr("Download folder")
                value: getName(config.readConfig("Dropbox/download_folder", config.getHome() + "/Downloads"))
                onClicked: {
                    pageStack.push("SelDownloadFolder.qml")
                }
            }

            ValueButton {
                id: uploadValue
                label: qsTr("Upload folder")
                value: getName(config.readConfig("Dropbox/upload_folder","/Public"))
                onClicked: {
                    pageStack.push("DropboxUploadFolder.qml")
                }
            }

        }
    }



}
