import UIKit

// Quality of service (prioritet)

/*
 QOS_CLASS_USER_INTERACTIVE - (высокий приоритет, но ниже main) пользователь взаимодействует с UI
 прям сейчас. (жесты) - интенсивна обработка данных
 QOS_CLASS_USER_INITIATED - (ниже INTERACTIVE) пользователь после действия ожидает что-то,
 но не внутри QOS_CLASS_USER_INTERACTIVE, пользователь готов немного подождать
 QOS_CLASS_DEFAULT - (на выбор системы) загрузка, какая-то обработка и тд
 QOS_CLASS_UTILITY - (ниже INITIATED) обычно для задач в фоновом режиме (например очиста данных)
 QOS_CLASS_BACKGROUND - (самый низкий приоритет) не точного времени здесь и сейчас (сегодня, завтра)
 QOS_CLASS_UNSPECIFIED ?
 */

/*
 QOS_CLASS_USER_INTERACTIVE  = immediately. For example, animations, changing the UI, etc.
 QOS_CLASS_USER_INITIATED    = few seconds or less
 QOS_CLASS_DEFAULT           = between user-initiated and utility
 QOS_CLASS_UTILITY           = few seconds - few minets
 QOS_CLASS_BACKGROUND        = minutes or hours
 QOS_CLASS_UNSPECIFIED ?
*/

var pthread = pthread_t(bitPattern: 0)
var attr = pthread_attr_t()
pthread_attr_init(&attr)

pthread_attr_set_qos_class_np(&attr, QOS_CLASS_USER_INITIATED, 0)
pthread_create(&pthread, &attr, { pointer in
    print("test")
    pthread_set_qos_class_self_np(QOS_CLASS_BACKGROUND, 0)
    return nil
}, nil)

// above equal to below

let nsThread = Thread {
    print("test")
    print(qos_class_self())
}

nsThread.qualityOfService = .userInteractive
nsThread.start()

print(qos_class_main())


