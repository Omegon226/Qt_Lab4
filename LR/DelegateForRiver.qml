import QtQuick 2.6
import QtQuick.Controls 2.5  // это версия библиотеки, содержащей Contol (аналоги виджетов) для версии Qt 5.6
import QtQuick.Layouts 1.2

Rectangle {
    id: rivItem
    readonly property color evenBackgroundColor: "#F8F8FF"  // цвет для четных пунктов списка
    readonly property color oddBackgroundColor: "#EEE8AA"   // цвет для нечетных пунктов списка
    readonly property color selectedBackgroundColor: "#9400D3"  // цвет выделенного элемента списка

    property bool isCurrent: rivItem.ListView.view.currentIndex === index   // назначено свойство isCurrent истинно для текущего (выделенного) элемента списка
    property bool selected: rivItemMouseArea.containsMouse || isCurrent // назначено свойство "быть выделенным",
    //которому присвоено значение "при наведении мыши,
    //или совпадении текущего индекса модели"

    property variant riverData: model // свойство для доступа к данным конкретного студента

    width: parent ? parent.width : rivList.width
    height: 150

    // состояние текущего элемента (Rectangle)
    states: [
        State {
            when: selected
            // как реагировать, если состояние стало selected
            PropertyChanges { target: rivItem;  // для какого элемента должно назначаться свойство при этом состоянии (selected)
                color: isCurrent ? palette.highlight : selectedBackgroundColor  /* какое свойство целевого объекта (Rectangle)
                                                                                                  и какое значение присвоить*/
            }
        },
        State {
            when: !selected
            PropertyChanges { target: rivItem;  color: isCurrent ? palette.highlight : index % 2 == 0 ? evenBackgroundColor : oddBackgroundColor }
        }
    ]

    MouseArea {
        id: rivItemMouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            rivItem.ListView.view.currentIndex = index
            rivItem.forceActiveFocus()
        }
    }
    Item {
        id: itemOfRivers
        width: parent.width
        height: 150
        Column{
            id: t2
            anchors.left: parent.left
            anchors.leftMargin: 10
            width: 240
            anchors.verticalCenter: parent.verticalCenter
            Text {
                id: t1
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Название реки:"
                color: "Indigo"
                font.pointSize: 12
            }
            Text {
                id: textName
                anchors.horizontalCenter: parent.horizontalCenter
                text: NameOfRiver
                color: "Indigo"
                font.pointSize: 18
                font.bold: true
            }
        }

        Column{
            anchors.left: t2.right
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            Text {
                text: "Протяжённость"
                color: "Indigo"
                font.pointSize: 8
            }
            Text {
                id: textLength
                text: LengthOfRiver
                color: "Indigo"
                font.pointSize: 8
            }
            Text {
                text: "Куда впадает река"
                color: "Indigo"
                font.pointSize: 8
            }
            Text {
                id: textFall
                color: "Indigo"
                text: FallInRiver
                font.pointSize: 8
            }
            Text {
                text: "Годовой сток"
                color: "Indigo"
                font.pointSize: 8
            }
            Text {
                id: textSink
                color: "Indigo"
                text: SinkOfRiver
                font.pointSize: 8
            }
            Text {
                text: "Площадь бассейна"
                color: "Indigo"
                font.pointSize: 8
            }
            Text {
                id: textSquare
                color: "Indigo"
                text: SquareOfRiver
                font.pointSize: 8
            }
        }

    }
}
