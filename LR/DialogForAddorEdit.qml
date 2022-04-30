import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.5   // это версия библиотеки, содержащей Contol (аналоги виджетов) для версии Qt 5.6
import QtQuick.Layouts 1.2


Window {
    id: root
    modality: Qt.ApplicationModal  // окно объявляется модальным
    title: qsTr("Информация о реке")
    minimumWidth: 400
    maximumWidth: 400
    minimumHeight: 350
    maximumHeight: 350

    property bool isEdit: false
    property int currentIndex: -1

    GridLayout {
        anchors { left: parent.left; top: parent.top; right: parent.right; bottom: buttonCancel.top; margins: 10 }
        columns: 2

        Label {
            Layout.alignment: Qt.AlignRight  // выравнивание по правой стороне
            text: qsTr("Название реки:")
        }
        TextField {
            id: textName
            Layout.fillWidth: true
            placeholderText: qsTr("Введите название реки")
        }
        Label {
            Layout.alignment: Qt.AlignRight
            text: qsTr("Протяжённость:")
        }
        TextField {
            id: textLength
            Layout.fillWidth: true
            placeholderText: qsTr("Введите протяжённость реки")
        }
        Label {
            Layout.alignment: Qt.AlignRight
            text: qsTr("Куда впадает:")
        }
        TextField {
            id: textFall
            Layout.fillWidth: true
            placeholderText: qsTr("Введите название реки в которую впадает данная река")
        }
        Label {
            Layout.alignment: Qt.AlignRight
            text: qsTr("Годовой сток:")
        }
        TextField {
            id: textSink
            Layout.fillWidth: true
            placeholderText: qsTr("Введите годовой сток реки")
        }
        Label {
            Layout.alignment: Qt.AlignRight
            text: qsTr("Площадь бассейна:")
        }
        TextField {
            id: textSquare
            Layout.fillWidth: true
            placeholderText: qsTr("Введите площадь бассейна")
        }
    }

    Button {
        anchors { right: buttonCancel.left; verticalCenter: buttonCancel.verticalCenter; rightMargin: 10 }
        text: qsTr("ОК")
        width: 100
        onClicked: {
            root.hide()
            if (currentIndex<0)
            {
                add(textName.text, textLength.text, textFall.text, textSink.text, textSquare.text)
            }
            else
            {
                edit(textName.text, textLength.text, textFall.text, textSink.text, textSquare.text, root.currentIndex)
            }

        }
    }

    Button {
        id: buttonCancel
        anchors { right: parent.right; bottom: parent.bottom; rightMargin: 10; bottomMargin: 10 }
        text: qsTr("Отменить")
        width: 100
        onClicked: {
             root.hide()
        }
    }

    // изменение статуса видимости окна диалога
    //!!!!
    onVisibleChanged: {
      if (visible && currentIndex < 0) {
          textName.text = ""
          textLength.text = ""
          textFall.text = ""
          textSink.text = ""
          textSquare.text = ""
      }
    }

    function execute(nameRiv, lengthRiv, fallRiv, sinkRiv, squareRiv, index){
        isEdit = true

        textName.text = nameRiv
        textLength.text = lengthRiv
        textFall.text = fallRiv
        textSink.text = sinkRiv
        textSquare.text = squareRiv

        root.currentIndex = index

        root.show()
    }


 }
