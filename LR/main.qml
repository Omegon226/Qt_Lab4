import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.5  // это версия библиотеки, содержащей Contol (аналоги виджетов) для версии Qt 5.6
import QtQuick.Layouts 1.2


Window {
    visible: true
    width: 720
    height: 480
    title: qsTr("Справочник Гидролога Смирнов И.М. 3-41хх")

    // объявляется системная палитра
    SystemPalette {
          id: palette;
          colorGroup: SystemPalette.Active
       }

    Rectangle{
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: btnAdd.top
        anchors.bottomMargin: 8
        border.color: "gray"

    ScrollView {
        anchors.fill: parent
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        //flickableItem.interactive: true  // сохранять свойство "быть выделенным" при потере фокуса мыши

        Text {
            anchors.fill: parent
            text: "Could not connect to SQL"
            color: "red"
            font.pointSize: 20
            font.bold: true
            visible: IsConnectionOpen == false
        }

        ListView {
            id: rivList
            anchors.fill: parent
            model: riverModel // назначение модели, данные которой отображаются списком
            delegate: DelegateForRiver{}
            clip: true //
            activeFocusOnTab: true  // реагирование на перемещение между элементами ввода с помощью Tab
            focus: true  // элемент может получить фокус
            opacity: {if (IsConnectionOpen == true) {100} else {0}}
        }
    }
   }

    Button {
        id: btnAdd
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        anchors.rightMargin: 8
        anchors.right:btnEdit.left
        text: "Добавить"
        width: 100

        onClicked: {
            windowAddEdit.currentIndex = -1
            windowAddEdit.show()
        }
    }

    Button {
        id: btnEdit
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        anchors.right: btnDel.left
        anchors.rightMargin: 8
        text: "Редактировать"
        width: 100
        onClicked: {
            var nameRiv = rivList.currentItem.riverData.NameOfRiver
            var lengthRiv = rivList.currentItem.riverData.LengthOfRiver
            var fallRiv = rivList.currentItem.riverData.FallInRiver
            var sinkRiv = rivList.currentItem.riverData.SinkOfRiver
            var squareRiv = rivList.currentItem.riverData.SquareOfRiver
            var index = rivList.currentItem.riverData.Id

            windowAddEdit.execute(nameRiv, lengthRiv, fallRiv, sinkRiv, squareRiv, index)
        }
    }

    Button {
        id: btnDel
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        anchors.right:parent.right
        anchors.rightMargin: 8
        text: "Удалить"
        width: 100
        enabled: {
            if (rivList.currentItem==null || rivList.currentItem.riverData == null)
            {false}
            else
            {rivList.currentItem.riverData.Id >= 0} }
        onClicked: del(rivList.currentItem.riverData.Id)
    }

    Label {
        id: labelArea
        // Устанавливаем расположение надписи
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 12
        anchors.left: parent.left
        anchors.rightMargin: 8
        anchors.leftMargin: 8
        // Выравниваем по правой стороне
        Layout.alignment: Qt.AlignRight
        // Настраиваем текст
        text: qsTr("Введите S бассейна:")
    }

    TextField {
        id: textSelArea
        Layout.fillWidth: true
        // Устанавливае что может быть введено в поле
        validator: IntValidator {bottom: 0;}
        // Позволяет установить текст до ввода информации
        placeholderText: qsTr("Число >= 0")
        // Устанавливаем расположение кнопки
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.leftMargin: 20
        anchors.left: labelArea.right
        anchors.rightMargin: 8
    }

    Button {
        id: butCount
        // Устанавливаем расположение кнопки
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        anchors.left: textSelArea.right
        anchors.leftMargin: 8
        // Устанавливаем текст
        text: "Подсчитать"
        // Устанавливаем ширину кнопки
        width: 100
        // Указываем условие при котором эта кнопка будет активна
        enabled: textSelArea.text != ""
        // Устанавливаем функцию
        onClicked: {
            windowAnswer.countRivers(textSelArea.text)
        }
    }

    DialogForAddorEdit {
        id: windowAddEdit
    }

    DialogForAnswer {
        id: windowAnswer
    }
}
