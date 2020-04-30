// Copyright (c) 2018 Ultimaker B.V.
// Cura is released under the terms of the LGPLv3 or higher.

import QtQuick 2.10
import QtQuick.Controls 2.3

import UM 1.4 as UM
import Cura 1.1 as Cura

Column
{
    width: Math.max(title.width, accountButton.width) + 2 * UM.Theme.getSize("default_margin").width

    spacing: UM.Theme.getSize("default_margin").height

    SystemPalette
    {
        id: palette
    }

    Label
    {
        id: title
        anchors.horizontalCenter: parent.horizontalCenter
        horizontalAlignment: Text.AlignHCenter
        renderType: Text.NativeRendering
        text: catalog.i18nc("@label The argument is a username.", "Hi %1").arg(profile.username)
        font: UM.Theme.getFont("large_bold")
        color: UM.Theme.getColor("text")
    }

    Row
    {
        width: childrenRect.width
        height: childrenRect.height
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: UM.Theme.getSize("narrow_margin").height


        UM.RecolorImage
        {
            width: 20 * screenScaleFactor
            height: width

            source: UM.Theme.getIcon("update")
            color: palette.text

            RotationAnimator
            {
                from: 0;
                to: 360;
                duration: 1500
                loops: Animation.Infinite
                running: false
            }

        }

        Label
        {
            id: accountSyncButton
            text: catalog.i18nc("@button", "Check for account updates")
            color: UM.Theme.getColor("secondary_button_text")
            font: UM.Theme.getFont("medium")
            renderType: Text.NativeRendering

            MouseArea
            {
                anchors.fill: parent
                onClicked: Cura.API.account.sync()
                hoverEnabled: true
                onEntered: accountSyncButton.font.underline = true
                onExited: accountSyncButton.font.underline = false
            }
        }
    }

    Cura.SecondaryButton
    {
        id: accountButton
        anchors.horizontalCenter: parent.horizontalCenter
        width: UM.Theme.getSize("account_button").width
        height: UM.Theme.getSize("account_button").height
        text: catalog.i18nc("@button", "Ultimaker account")
        onClicked: Qt.openUrlExternally(CuraApplication.ultimakerCloudAccountRootUrl)
        fixedWidthMode: false
    }

    Label
    {
        id: signOutButton
        anchors.horizontalCenter: parent.horizontalCenter
        text: catalog.i18nc("@button", "Sign out")
        color: UM.Theme.getColor("secondary_button_text")
        font: UM.Theme.getFont("medium")
        renderType: Text.NativeRendering

        MouseArea
        {
            anchors.fill: parent
            onClicked: Cura.API.account.logout()
            hoverEnabled: true
            onEntered: signOutButton.font.underline = true
            onExited: signOutButton.font.underline = false
        }
    }
}
