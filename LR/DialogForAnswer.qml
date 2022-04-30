import QtQuick 6.0
import QtQuick.Window 6.0
import QtQuick.Controls 6.0
import QtQuick.Layouts 6.0

// Окно ответа на условие о размере бассейна
Window {
    id: root
    // Говорим, что это окно является модальным
    modality: Qt.ApplicationModal
    title: qsTr("Ответ")
    width: 220
    height: 50

    // Создаём Grid в котором будем размещать элементы
    GridLayout {
        // Задаём размещение этого Grid
        anchors { left: parent.left;
                  top: parent.top;
                  right: parent.right;
                  margins: 10 }
        // И говорим, что у этого Grid будет 2 колонки для текста и ответа
        columns: 2

        // Label для того, чтобы понять, что мы вывели
        Label {
            Layout.alignment: Qt.AlignRight
            text: qsTr("Получившийся результат:")
        }
        // Label для текста ответа
        Label {
            id: textCount
            Layout.fillWidth: true
        }

    }

    // Задаём функция для вывода информации
    function countRivers(area){
        textCount.text = count(area);
        root.show()
    }
 }
