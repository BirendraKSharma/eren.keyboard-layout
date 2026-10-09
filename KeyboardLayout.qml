import QtQuick
import Quickshell
import Quickshell.Io
import qs.Ui
import qs.Commons

// Fcitx5 owns Mozc's English/Japanese state; Hyprland's XKB layout is always
// US here, so the stock keyboard-layout widget cannot describe this toggle.
BarWidget {
  id: root
  moduleName: "omarchy.keyboard-layout"

  property string state: ""
  readonly property bool active: state === "2"
  readonly property bool available: state === "1" || state === "2"
  readonly property string label: active ? "あ" : "EN"

  function refresh() {
    if (!stateProc.running) stateProc.running = true
  }

  Component.onCompleted: refresh()

  Process {
    id: stateProc
    command: ["fcitx5-remote"]
    stdout: StdioCollector {
      waitForEnd: true
      onStreamFinished: root.state = String(text || "").trim()
    }
  }

  Process {
    id: toggleProc
    command: ["fcitx5-remote", "-t"]
    onRunningChanged: {
      if (!running) refreshTimer.restart()
    }
  }

  Timer {
    id: refreshTimer
    interval: 150
    onTriggered: root.refresh()
  }

  // Fcitx5 does not emit Hyprland layout events, so poll its compact status.
  Timer {
    interval: 750
    running: true
    repeat: true
    onTriggered: root.refresh()
  }

  visible: available
  implicitWidth: button.implicitWidth
  implicitHeight: button.implicitHeight

  WidgetButton {
    id: button
    anchors.fill: parent
    bar: root.bar
    text: root.label
    fontSize: Style.font.caption
    horizontalMargin: 6
    tooltipText: root.active ? "Japanese input (Mozc) — click for English" : "English input — click for Japanese (Mozc)"
    onPressed: function() {
      if (!toggleProc.running) toggleProc.running = true
    }
  }
}
