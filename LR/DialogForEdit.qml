import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 1.4  // это версия библиотеки, содержащей Contol (аналоги виджетов) для версии Qt 5.6
import QtQuick.Layouts 1.2


Window {
    id: root
    modality: Qt.ApplicationModal  // окно объявляется модальным
    title: qsTr("Редактирование информации о студенте")
    minimumWidth: 400
    maximumWidth: 400
    minimumHeight: 200
    maximumHeight: 200

    property int currentIndex: -1

    GridLayout {
        anchors { left: parent.left; top: parent.top; right: parent.right; bottom: buttonCancel.top; margins: 10 }
        columns: 2

        Label {
            Layout.alignment: Qt.AlignRight  // выравнивание по правой стороне
            text: qsTr("Имя студента:")
        }
        TextField {
            id: textName
            Layout.fillWidth: true
            placeholderText: qsTr("Введите ФИО")
        }
        Label {
            Layout.alignment: Qt.AlignRight
            text: qsTr("Номер читательского билета:")
        }
        TextField {
            id: textNumber
            Layout.fillWidth: true
            placeholderText: qsTr("Введите номер читательского билета")
        }
        Label {
            Layout.alignment: Qt.AlignRight
            text: qsTr("Количество выданных книг:")
        }
        TextField {
            id: textCount
            Layout.fillWidth: true
            placeholderText: qsTr("Введите количество выданных книг")
        }
    }

    Button {
        anchors { right: buttonCancel.left; verticalCenter: buttonCancel.verticalCenter; rightMargin: 10 }
        text: qsTr("Применить")
        width: 100
        onClicked: {
            root.hide()
            edit(textName.text, textNumber.text, textCount.text, root.currentIndex)
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


    function execute(name, number, count, index){
        textName.text = name
        textNumber.text = number
        textCount.text = count
        root.currentIndex = index

        root.show()
    }
 }
