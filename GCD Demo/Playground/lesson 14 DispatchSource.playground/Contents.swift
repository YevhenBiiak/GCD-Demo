import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

// MARK: - DispatchSource

/// Объект, координирующий обработку определенных низкоуровневых системных событий.
/// таких как события файловой системы, таймеры и сигналы UNIX.

// timer in another queue
let timer = DispatchSource.makeTimerSource(queue: .global())
timer.setEventHandler {
    print("!")
}
timer.schedule(deadline: .now(), repeating: 5)
timer.activate()

